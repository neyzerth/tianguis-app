import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, TextInput, Pressable } from 'react-native';
import React, { useMemo, useState } from 'react';
import RadioGroup from 'react-native-radio-buttons-group';

export default function App() {

    const radioButtons = useMemo(() => ([
        {
            id: '1',
            label: 'Seller',
            value: 'seller',
            color: '#f44336'
        },
        {
            id: '2',
            label: 'Buyer',
            value: 'buyer',
            color: '#f44336'
        }
    ]), []);

    const [selectedId, setSelectedId] = useState();

  return (
    <View style={styles.container}>
        <Text style={styles.title}>Sign up</Text>
        <Text style={styles.subtitle}>Create your account</Text>
        <TextInput
          style={styles.input}
          placeholder="Name"
          keyboardType="text"
        />
        <TextInput
          style={styles.input}
          placeholder="Last name"
          keyboardType="text"
        />
        <TextInput
          style={styles.input}
          placeholder="Email"
          keyboardType="text"
        />
        <TextInput
          style={styles.input}
          placeholder="Phone"
          keyboardType="numeric"
        />
        <TextInput
          style={styles.input}
          placeholder="Password"
          keyboardType="text"
          secureTextEntry={true}
        />
        <View style={styles.radio}>
            <RadioGroup 
                radioButtons={radioButtons} 
                onPress={setSelectedId}
                selectedId={selectedId}
            />
        </View>
        
        <Pressable style={styles.btnSignup}>
            <Text style={styles.btnSignupText}>Sign up</Text>
        </Pressable>

        <Pressable style={styles.btnLogin}>
            <Text style={styles.btnLoginText}>Log in</Text>
        </Pressable>
        
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
  radio: {
  },
  social: {
    flexDirection:'row',
    padding: 10,
    justifyContent: 'space-between',

  },
  logo:{
    position: 'absolute',
    top: 0,
    width: 200,
    resizeMode: 'contain'
  },
  title: {
    color: '#000',
    fontSize: 30
  },
  subtitle: {
    color: '#aaa',
    fontSize: 15
  },
  btnSocial: {
    backgroundColor: '#f44336',
    height: 50,
    width: 50,
    borderRadius: 10,
    alignItems: 'center',
    justifyContent: 'center',
    margin: 5
  },
  input: {
    height: 50,
    width: 350,
    margin: 12,
    borderRadius: 10,
    padding: 10,
    backgroundColor: '#f5f5f5'
  },
  btnSignup: {
    height: 50,
    width: 350,
    margin: 12,
    borderRadius: 15,
    padding: 10,
    justifyContent: 'center',
    backgroundColor: '#f44336',
  },
  btnSignupText: {
    textAlign: 'center',
    color: '#fff',
    fontWeight: 'bold'
  },
  btnLogin: {
    margin: 5,
    padding: 5,
    justifyContent: 'center',
  },
  btnLoginText: {
    textAlign: 'center',
    color: '#aaa'
  }
  
});
