import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

// Importar pantallas de autenticación
import Login from '../screens/auth/login/login';
import Signup from '../screens/auth/signup/signup';

// Importar navegador de vendedor
import SellerNavigator from ' ./sellerNavigator';

const Stack = createStackNavigator();

export default function Navigation() {
  return (
    <NavigationContainer>
      <Stack.Navigator 
        initialRouteName="Login" 
        screenOptions={{
          headerShown: false
        }}
      >
        <Stack.Screen name="Login" component={Login} />
        <Stack.Screen name="Signup" component={Signup} />
        <Stack.Screen name="SellerHome" component={SellerNavigator} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}