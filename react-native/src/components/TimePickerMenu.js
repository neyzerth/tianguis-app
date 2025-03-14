import React, { useState } from 'react';
import {StyleSheet} from 'react-native';
import { Menu, Button } from 'react-native-paper';

const TimePickerMenu = ({ label, options, selectedValue, onSelect }) => {
  const [visible, setVisible] = useState(false);

  return (
    <Menu
      visible={visible}
      onDismiss={() => setVisible(false)}
      anchor={
        <Button onPress={() => setVisible(true)} style={styles.menuButton}>
          {selectedValue}
        </Button>
      }
    >
      {options.map((option) => (
        <Menu.Item
          key={option}
          onPress={() => {
            onSelect(option);
            setVisible(false);
          }}
          title={option}
        />
      ))}
    </Menu>
  );
};

export default TimePickerMenu;

const styles = StyleSheet.create({
    menuButton: {
        marginLeft: 10,
      }
});