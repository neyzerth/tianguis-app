import React from 'react';
import { StyleSheet, Text, TextInput, Pressable } from 'react-native';

// Definir colores de la aplicación
export const TianguisColors = {
  red: '#f44336',
  white: '#ffffff',
  lightGray: '#f5f5f5',
  gray: '#aaaaaa',
  black: '#000000'
};

// TextBox personalizado
export function TextBox({ placeholder, keyboardType = 'default', secureText = false }) {
  return (
    <TextInput 
      style={styles.input} 
      placeholder={placeholder} 
      keyboardType={keyboardType}
      secureTextEntry={secureText}
    />
  );
}

// Botón principal
export function TianguisButton({ text, color = TianguisColors.red, onPress }) {
  return (
    <Pressable 
      style={[styles.button, { backgroundColor: color }]}
      onPress={onPress}
    >
      <Text style={styles.buttonText}>{text}</Text>
    </Pressable>
  );
}

// Botón de texto
export function TianguisButtonText({ text, onPress }) {
  return (
    <Pressable style={styles.textButton} onPress={onPress}>
      <Text style={styles.textButtonText}>{text}</Text>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  input: {
    height: 50,
    width: 350,
    margin: 12,
    borderRadius: 10,
    padding: 10,
    backgroundColor: TianguisColors.lightGray
  },
  button: {
    height: 50,
    width: 350,
    margin: 12,
    borderRadius: 15,
    padding: 10,
    justifyContent: 'center',
  },
  buttonText: {
    textAlign: 'center',
    color: TianguisColors.white,
    fontWeight: 'bold'
  },
  textButton: {
    margin: 5,
    padding: 5,
    justifyContent: 'center',
  },
  textButtonText: {
    textAlign: 'center',
    color: TianguisColors.gray
  }
});