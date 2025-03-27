import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import Login from '../screens/auth/login/login';
import Signup from '../screens/auth/signup/signup';
import SellerNavigator from '../sellerNavigator'; 
import CustomerNavigation from '../CustomerNavigation'; 

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
        <Stack.Screen name="CustomerNavigation" component={CustomerNavigation} /> 
      </Stack.Navigator>
    </NavigationContainer>
  );
}