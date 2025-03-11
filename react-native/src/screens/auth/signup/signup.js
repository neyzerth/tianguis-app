import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View } from 'react-native';
import React, { useMemo, useState } from 'react';
import RadioGroup from 'react-native-radio-buttons-group';
import TianguisButton from '../../../components/TianguisButton';
import TianguisButtonText from '../../../components/TianguisButtonText';
import TextBox from '../../../components/TextBox';
import {TianguisColors} from '../../../constants/TianguisColors';
import { useNavigation } from "@react-navigation/native";


export default function App() {

    const radioButtons = useMemo(() => ([
        {
            id: '1',
            label: 'Seller',
            value: 'seller',
            color: TianguisColors.red
        },
        {
            id: '2',
            label: 'Buyer',
            value: 'buyer',
            color: TianguisColors.red
        }
    ]), []);

    const [selectedId, setSelectedId] = useState();

  return (
    <View style={styles.container}>
        <Text style={styles.title}>Sign up</Text>
        <Text style={styles.subtitle}>Create your account</Text>

        <TextBox
            placeholder="Name"
            keyboardType="text"
        />
        <TextBox
            placeholder="Last name"
            keyboardType="text"
        />
        <TextBox
            placeholder="Email"
            keyboardType="text"
        />
        <TextBox
            placeholder="Phone"
            keyboardType="numeric"
        />
        <TextBox
            placeholder="Password"
            keyboardType="text"
            secureText={true}
        />

        <RadioGroup 
            radioButtons={radioButtons} 
            onPress={setSelectedId}
            selectedId={selectedId}
        />

        <TianguisButton text="Sign up" color={TianguisColors.red}></TianguisButton>

        <TianguisButtonText text="Log in"></TianguisButtonText>
        
        <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  title: {
    fontSize: 30
  },
  subtitle: {
    color: '#aaa',
    fontSize: 15
  },
});
