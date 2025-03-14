import React from 'react';
import { StyleSheet, Text, View, TextInput, Image, Pressable } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import { useNavigation } from "@react-navigation/native";
import { BlackLogo } from '../../../components/Logo';

export default function Login() {
  const navigation = useNavigation();

  const handleLogin = () => {
    console.log("Intento de login");
    navigation.navigate('SellerHome');

  };

  return (
    <View style={styles.container}>
        <BlackLogo/>
        <Text style={styles.title}>Log in</Text>
        <Text style={styles.subtitle}>Log in with social networks</Text>
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
        <Text style={styles.subtitle}>Or</Text>
        <TextInput style={styles.input} placeholder="Email" keyboardType="email-address" />
        <TextInput style={styles.input} placeholder="Password" secureTextEntry={true} />
        <Pressable style={styles.btnForgot}>
            <Text style={styles.btnForgotText}>Forgot Password?</Text>
        </Pressable>
        
        <Pressable style={styles.btnLogin} onPress={handleLogin}>
            <Text style={styles.btnLoginText}>Log in</Text>
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