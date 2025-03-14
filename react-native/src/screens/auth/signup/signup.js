import React, { useMemo, useState } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { StatusBar } from 'expo-status-bar';
import RadioGroup from 'react-native-radio-buttons-group';
import { useNavigation } from "@react-navigation/native";
import {TianguisColors} from '../../../constants/TianguisColors';
import { 
  TianguisButton, 
  TianguisButtonText, 
  TextBox
} from '../../../components/TianguisComponents'; 

export default function SignupScreen() {
  const navigation = useNavigation();
  
  const radioButtons = useMemo(() => ([
    { id: '1', label: 'Seller', value: 'seller', color: TianguisColors.red },
    { id: '2', label: 'Buyer', value: 'buyer', color: TianguisColors.red }
  ]), []);

  const [selectedId, setSelectedId] = useState();
  
  return (
    <View style={styles.container}>
        <Text style={styles.title}>Sign up</Text>
        <Text style={styles.subtitle}>Create your account</Text>

        <TextBox placeholder="Name" keyboardType="default" />
        <TextBox placeholder="Last name" keyboardType="default" />
        <TextBox placeholder="Email" keyboardType="email-address" />
        <TextBox placeholder="Phone" keyboardType="numeric" />
        <TextBox placeholder="Password" keyboardType="default" secureText={true} />

        <RadioGroup radioButtons={radioButtons} onPress={setSelectedId} selectedId={selectedId} />

        <TianguisButton text="Sign up" color={TianguisColors.red} />
        
        <TianguisButtonText text="Log in" onPress={() => navigation.navigate('Login')} />
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