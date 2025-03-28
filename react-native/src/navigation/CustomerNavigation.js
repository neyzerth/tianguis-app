import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import CustomerBottomTab from './CustomerBottomTab';

const Stack = createStackNavigator();

export default function CustomerNavigation() {
  return (
    <Stack.Navigator 
      initialRouteName="CustomerBottomTab" 
      screenOptions={{
        headerShown: false
      }}
    >
      <Stack.Screen name="CustomerBottomTab" component={CustomerBottomTab} />
    </Stack.Navigator>
  );
}