import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import MaterialCommunityIcons from '@expo/vector-icons/MaterialCommunityIcons';
import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import Ionicons from '@expo/vector-icons/Ionicons';

// Importar pantallas del vendedor
import MyItems from '../screens/seller/MyItems';
import MyStands from '../screens/seller/MyStands';
import Profile from '../screens/seller/Profile';

const Tab = createBottomTabNavigator();

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
        component={MyStands} 
        initialParams={{ userId }}
        options={{
          title: "My Stands",
          tabBarIcon: ({ color, size }) => (
            <MaterialIcons name="storefront" size={size} color={color} />
          ),
        }}
      />
      <Tab.Screen 
        name="Profile" 
        component={Profile} 
        initialParams={{ userId }}
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