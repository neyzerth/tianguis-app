import React, { useMemo, useState } from 'react';
import { StyleSheet, Text, View, Alert } from 'react-native';
import RadioGroup from 'react-native-radio-buttons-group';
import { useNavigation } from "@react-navigation/native";
import { TianguisColors } from '../../../constants/TianguisColors';
import { supabase } from '../../../config/supabase';
import { 
  TianguisButton, 
  TianguisButtonText, 
  TextBox
} from '../../../components/TianguisComponents'; 

export default function SignupScreen() {
  const navigation = useNavigation();
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [password, setPassword] = useState('');
  const [selectedId, setSelectedId] = useState('2'); // default to customer

  const radioButtons = useMemo(() => ([
    { id: '1', label: 'Seller', value: 'seller', color: TianguisColors.red },
    { id: '2', label: 'Customer', value: 'customer', color: TianguisColors.red }
  ]), []);

  const handleSignup = async () => {
    try {
      // Validate fields
      if (!firstName || !email || !password) {
        Alert.alert('Error', 'Please fill all required fields');
        return;
      }

      const role = selectedId === '1' ? 'seller' : 'customer';
      
      // Insert into user table
      const { data, error } = await supabase
        .from('user')
        .insert([
          {
            first_name: firstName,
            last_name: lastName,
            email: email,
            password: password,
            phone: phone,
            role: role
          }
        ])
        .select()
        .single();

      if (error) throw error;

      // Navigate based on role
      if (role === 'seller') {
        navigation.navigate('SellerNavigation');
      } else {
        navigation.navigate('CustomerNavigation');
      }
      
    } catch (error) {
      Alert.alert('Error', error.message);
    }
  };
  
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Sign up</Text>
      <Text style={styles.subtitle}>Create your account</Text>

      <TextBox 
        placeholder="Name *" 
        value={firstName}
        onChangeText={setFirstName}
      />
      <TextBox 
        placeholder="Last name" 
        value={lastName}
        onChangeText={setLastName}
      />
      <TextBox 
        placeholder="Email *" 
        keyboardType="email-address"
        value={email}
        onChangeText={setEmail}
      />
      <TextBox 
        placeholder="Phone" 
        keyboardType="numeric"
        value={phone}
        onChangeText={setPhone}
      />
      <TextBox 
        placeholder="Password *" 
        secureText={true}
        value={password}
        onChangeText={setPassword}
        autoCapitalize="none"
      />

      <RadioGroup 
        radioButtons={radioButtons} 
        onPress={setSelectedId} 
        selectedId={selectedId}
      />

      <TianguisButton 
        text="Sign up" 
        onPress={handleSignup}
        color={TianguisColors.red} 
      />
      
      <TianguisButtonText 
        text="Log in" 
        onPress={() => navigation.navigate('Login')} 
      />
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