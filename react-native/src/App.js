import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import Login from './screens/auth/login/login';
import Signup from './screens/auth/signup/signup';

// navegador de vendedor
import SellerNavigator from './navigation/sellerNavigator';

//pantalla de añadir item
import AddItem from './screens/seller/AddItem';

//pantalla de Item individual
import MyItems from './screens/seller/MyItems';
import Item from './screens/seller/Item';

const Stack = createStackNavigator();

export default function App() {
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
        <Stack.Screen name="AddItem" component={AddItem} />
        <Stack.Screen name="MyItems" component={MyItems} />
        <Stack.Screen name="Item" component={Item} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}