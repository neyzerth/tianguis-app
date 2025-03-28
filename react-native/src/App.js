import React, { useEffect, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import Splash from './screens/Splash';
import Login from './screens/auth/login/login';
import Signup from './screens/auth/signup/signup';
import ItemsNearMe from './screens/customer/ItemsNearMe';
import AddItem from './screens/seller/AddItem';

//pantalla de Item individual
import MyItems from './screens/seller/MyItems';
import Item from './screens/seller/Item';
import Saved from './screens/seller/Saved';
import EditItem from './screens/seller/EditItem';
import EditProfile from './screens/seller/EditProfile';

//Navigators
import SellerNavigator from './navigation/sellerNavigator';
import CustomerNavigation from './navigation/CustomerNavigation';
import CustomerBottomTab from './navigation/CustomerBottomTab';

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
        <Stack.Screen name="SellerNavigation" component={SellerNavigator} />
        <Stack.Screen name="CustomerNavigation" component={CustomerNavigation} />
        <Stack.Screen name="ItemsNearMe" component={ItemsNearMe} />
        <Stack.Screen name="AddItem" component={AddItem} />
        <Stack.Screen name="MyItems" component={MyItems} />
        <Stack.Screen name="Item" component={Item} />
        <Stack.Screen name="Saved" component={Saved} />
        <Stack.Screen name="EditItem" component={EditItem} />
        <Stack.Screen name="EditProfile" component={EditProfile} />
        <Stack.Screen name="CustomerBottomTab" component={CustomerBottomTab} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}