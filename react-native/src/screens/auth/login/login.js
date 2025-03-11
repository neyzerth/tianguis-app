import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, TextInput, Image, Pressable } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import { useNavigation } from "@react-navigation/native";


export default function App() {
  return (
    <View style={styles.container}>
        <Image
            style={styles.logo}
            source={require('../../../assets/images/tianguisBlack.png')}
        />
        <Text style={styles.title}>Log in</Text>
        <Text style={styles.subtitle}>Log in with social networks</Text>
        <View style={styles.social}>
            <Pressable style={styles.btnSocial}>
                <Icon
                    name="facebook"
                    size={30}
                    color="#fff"
                />
            </Pressable>
            <Pressable style={styles.btnSocial}>
                <Icon
                    name="instagram"
                    size={30}
                    color="#fff"
                />
            </Pressable>
            <Pressable style={styles.btnSocial}>
                <Icon
                    name="google"
                    size={30}
                    color="#fff"
                />
            </Pressable>
        </View>
        <Text style={styles.subtitle}>Or</Text>
        <TextInput
          style={styles.input}
          placeholder="Email"
          keyboardType="text"
        />
        <TextInput
          style={styles.input}
          placeholder="Password"
          keyboardType="text"
          secureTextEntry={true}
        />
        <Pressable style={styles.btnForgot}>
            <Text style={styles.btnForgotText}>Forgot Password?</Text>
        </Pressable>
        
        <Pressable style={styles.btnLogin}>
            <Text style={styles.btnLoginText}>Log in</Text>
        </Pressable>
        
        <Pressable style={styles.btnSignup}>
            <Text style={styles.btnSignupText}>Sign up</Text>
            onPress={() => navigation.navigate('Signup')}
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
