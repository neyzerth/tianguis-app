import React, { useState } from 'react';
import { StyleSheet, Text, View, TextInput, Pressable, Alert } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import { useNavigation } from "@react-navigation/native";
import { BlackLogo } from '../../../components/Logo';
import { supabase } from '../../../config/supabase';

export default function Login() {
  const navigation = useNavigation();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  const handleLogin = async () => {
    if (!email || !password) {
      Alert.alert('Error', 'Please fill in all fields');
      return;
    }

    try {
      setLoading(true);
      
      // Buscar usuario directamente en la tabla user
      const { data: user, error } = await supabase
        .from('user')
        .select('*')
        .eq('email', email)
        .eq('password', password)
        .single();

      if (error) throw error;

      if (user) {
        // Guardar datos del usuario en localStorage o contexto global
        console.log('Usuario logueado:', user);
        
        // Navegar según el rol
        if (user.role === 'seller') {
          navigation.navigate('SellerNavigation');
        } else {
          navigation.navigate('CustomerNavigation');
        }
      } else {
        Alert.alert('Error', 'Invalid credentials');
      }
    } catch (error) {
      Alert.alert('Error', error.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <View style={styles.container}>
        <BlackLogo/>
        <Text style={styles.title}>Log in</Text>
        
        <View style={styles.social}>
            <Pressable style={styles.btnSocial}>
                <Icon name="facebook" size={30} color="#fff" />
            </Pressable>
            <Pressable style={styles.btnSocial}>
                <Icon name="instagram" size={30} color="#fff" />
            </Pressable>
            <Pressable style={styles.btnSocial}>
                <Icon name="google" size={30} color="#fff" />
            </Pressable>
        </View>

        <TextInput 
            style={styles.input} 
            placeholder="Email" 
            keyboardType="email-address"
            value={email}
            onChangeText={setEmail}
            autoCapitalize="none"
        />
        
        <TextInput 
            style={styles.input} 
            placeholder="Password" 
            secureTextEntry={true}
            value={password}
            onChangeText={setPassword}
            autoCapitalize="none"
        />
        
        <Pressable 
            style={[styles.btnLogin, loading && styles.btnDisabled]} 
            onPress={handleLogin}
            disabled={loading}
        >
            <Text style={styles.btnLoginText}>
                {loading ? 'Loading...' : 'Log in'}
            </Text>
        </Pressable>

        <Pressable style={styles.btnSignup} onPress={() => navigation.navigate('Signup')}>
            <Text style={styles.btnSignupText}>Sign up</Text>
        </Pressable>
      
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
  btnLogin: {
    height: 50,
    width: 350,
    margin: 12,
    borderRadius: 15,
    padding: 10,
    justifyContent: 'center',
    backgroundColor: '#f44336',
  },
  btnLoginText: {
    textAlign: 'center',
    color: '#fff',
    fontWeight: 'bold'
  },
  btnForgot: {
    margin: 5,
    padding: 5,
    justifyContent: 'center',
  },
  btnForgotText: {
    textAlign: 'center',
    color: '#aaa'
  },
  btnSignup: {
    margin: 5,
    padding: 5,
    justifyContent: 'center',
  },
  btnSignupText: {
    textAlign: 'center',
    color: '#aaa'
  }
});