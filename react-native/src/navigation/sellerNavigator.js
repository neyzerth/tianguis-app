import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import MaterialCommunityIcons from '@expo/vector-icons/MaterialCommunityIcons';
import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import Ionicons from '@expo/vector-icons/Ionicons';

// pantallas del vendedor
import MyItems from '../screens/seller/MyItems';
import MyStands from '../screens/seller/MyStands';
import Profile from '../screens/seller/Profile';
import EditProfile from '../screens/seller/EditProfile'; 
import WhatDoYouSell from '../screens/seller/whatDoYouSell';
import WhereDoYouSell from '../screens/seller/whereDoYouSell';

const Tab = createBottomTabNavigator();
const Stack = createStackNavigator();

function StandsStackNavigator({ route }) {
  const userId = route.params?.userId;
  
  return (
    <Stack.Navigator screenOptions={{ headerShown: false }}>
      <Stack.Screen name="StandsHome" component={MyStands} initialParams={{ userId }} />
      <Stack.Screen name="WhatDoYouSell" component={WhatDoYouSell} />
      <Stack.Screen name="WhereDoYouSell" component={WhereDoYouSell} />
    </Stack.Navigator>
  );
}

// New ProfileStackNavigator
function ProfileStackNavigator({ route }) {
  const userId = route.params?.userId;

  return (
    <Stack.Navigator screenOptions={{ headerShown: false }}>
      <Stack.Screen name="ProfileHome" component={Profile} initialParams={{ userId }} />
      <Stack.Screen name="EditProfile" component={EditProfile} initialParams={{ userId }} />
    </Stack.Navigator>
  );
}

export default function SellerNavigator({ route }) {
  const userId = route.params?.userId;

  return (
    <Tab.Navigator
      initialRouteName="MyItems"
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: "#f44336",
        tabBarInactiveTintColor: "#857b7b",
      }}
    >
      <Tab.Screen 
        name="MyItems" 
        component={MyItems} 
        initialParams={{ userId }}
        options={{
          title: "My Items",
          tabBarIcon: ({ color, size }) => (
            <MaterialCommunityIcons name="shopping-outline" size={size} color={color} />
          ),
        }}
      />
      <Tab.Screen 
        name="MyStands" 
        initialParams={{ userId }}
        component={StandsStackNavigator} 
        options={{
          title: "My Stands",
          tabBarIcon: ({ color, size }) => (
            <MaterialIcons name="storefront" size={size} color={color} />
          ),
        }}
      />
      <Tab.Screen 
        name="Profile" 
        initialParams={{ userId }}
        component={ProfileStackNavigator} 
        options={{
          title: "Profile",
          tabBarIcon: ({ color, size }) => (
            <Ionicons name="person-outline" size={size} color={color} />
          ),
        }}
      />
    </Tab.Navigator>
  );
}