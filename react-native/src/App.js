import React, { useEffect, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import Splash from './screens/Splash';
import Login from './screens/auth/login/login';
import Signup from './screens/auth/signup/signup';
import SellerNavigator from './navigation/sellerNavigator';
import AddItem from './screens/seller/AddItem';

//pantalla de Item individual
import MyItems from './screens/seller/MyItems';
import Item from './screens/seller/Item';
import Saved from './screens/seller/Saved';

const Stack = createStackNavigator();

export default function App() {
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    setTimeout(() => {
      setIsLoading(false);
    }, 2000); // Muestra el splash por 2 segundos
  }, []);

  if (isLoading) {
    return <Splash />;
  }

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
        <Stack.Screen name="Saved" component={Saved} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}