import React, { useState } from 'react';
import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View } from 'react-native';
import { Provider } from 'react-native-paper';
import TimePickerMenu from '../../components/TimePickerMenu';
import {TianguisButton} from '../../components/TianguisComponents';

export default function App() {
  const [selectedDay, setSelectedDay] = useState('Monday');

  const [selectedFromHour, setSelectedFromHour] = useState('12');
  const [selectedFromMinute, setSelectedFromMinute] = useState('00');
  const [selectedFromAmPm, setSelectedFromAmPm] = useState('AM');

  const [selectedToHour, setSelectedToHour] = useState('12');
  const [selectedToMinute, setSelectedToMinute] = useState('00');
  const [selectedToAmPm, setSelectedToAmPm] = useState('AM');

  const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  const hours = Array.from({ length: 12 }, (_, i) => (i + 1).toString().padStart(2, '0'));
  const minutes = Array.from({ length: 60 }, (_, i) => i.toString().padStart(2, '0'));
  const amPm = ['AM', 'PM'];

  return (
    <Provider>
      <View style={styles.container}>
        <View style={styles.content}>
            <Text style={styles.title}>Sales hours</Text>

            <View style={styles.time}>
                <Text style={styles.heading}>Day</Text>
                <TimePickerMenu
                    label="Day"
                    options={days}
                    selectedValue={selectedDay}
                    onSelect={setSelectedDay}
                />
            </View>

            <View style={styles.time}>
                <Text style={styles.heading}>From</Text>
                <View style={styles.timePicker}>
                    <TimePickerMenu
                    label="Hour"
                    options={hours}
                    selectedValue={selectedFromHour}
                    onSelect={setSelectedFromHour}
                    />
                    <Text style={styles.separator}>:</Text>
                    <TimePickerMenu
                    label="Minute"
                    options={minutes}
                    selectedValue={selectedFromMinute}
                    onSelect={setSelectedFromMinute}
                    />
                    <Text style={styles.separator}>:</Text>
                    <TimePickerMenu
                    label="AM/PM"
                    options={amPm}
                    selectedValue={selectedFromAmPm}
                    onSelect={setSelectedFromAmPm}
                    />
                </View>
            </View>

            <View style={styles.time}>
                <Text style={styles.heading}>To</Text>
                <View style={styles.timePicker}>
                    <TimePickerMenu
                    label="Hour"
                    options={hours}
                    selectedValue={selectedToHour}
                    onSelect={setSelectedToHour}
                    />
                    <Text style={styles.separator}>:</Text>
                    <TimePickerMenu
                    label="Minute"
                    options={minutes}
                    selectedValue={selectedToMinute}
                    onSelect={setSelectedToMinute}
                    />
                    <Text style={styles.separator}>:</Text>
                    <TimePickerMenu
                    label="AM/PM"
                    options={amPm}
                    selectedValue={selectedToAmPm}
                    onSelect={setSelectedToAmPm}
                    />
                </View>
            </View>
        </View>
        
        <View style={styles.buttonContainer}>
          <TianguisButton text="Enter" onPress={() => {}}/>
        </View>

        <StatusBar style="auto" />
    </View>
      
    </Provider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingTop: 50, 
    paddingBottom: 20, 
  },
  content: {
    width: '100%',
    alignItems: 'center',
  },
  title: {
    fontSize: 40,
    margin: 20,
  },
  time: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    width: '90%',
    marginVertical: 10,
  },
  heading: {
    color: '#111',
    fontSize: 30,
    fontWeight: 'bold',
  },
  timePicker: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  menuButton: {
    marginLeft: 10,
  },
  separator: {
    fontSize: 20,
    marginHorizontal: 5,
  },
  buttonContainer: {
    width: '100%',
    alignItems: 'center'
  }
});