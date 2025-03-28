import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Ionicons, MaterialIcons } from '@expo/vector-icons';

import ItemsNearMe from '../screens/customer/ItemsNearMe';
//import Favorites from '../screens/customer/Favorites';
//import Profile from '../screens/customer/Profile';

const Tab = createBottomTabNavigator();

export default function CustomerBottomTab() {
  return (
    <Tab.Navigator
      initialRouteName="ItemsNearMe"
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: "#f44336",
        tabBarInactiveTintColor: "#857b7b",
        tabBarStyle: {
          height: 60,
          paddingBottom: 10,
          paddingTop: 10,
        },
        tabBarLabelStyle: {
          fontSize: 12,
        }
      }}
    >
      <Tab.Screen 
        name="ItemsNearMe" 
        component={ItemsNearMe} 
        options={{
          title: "Items Near Me",
          tabBarIcon: ({ color, size }) => (
            <MaterialIcons name="near-me" size={size} color={color} />
          ),
        }}
      />
      {/* <Tab.Screen 
        name="Favorites" 
        //component={Favorites} 
        options={{
          title: "Favorites",
          tabBarIcon: ({ color, size }) => (
            <Ionicons name="heart-outline" size={size} color={color} />
          ),
        }}
      /> */}
      {/* <Tab.Screen 
        name="Profile" 
        //component={Profile} 
        options={{
          title: "Profile",
          tabBarIcon: ({ color, size }) => (
            <Ionicons name="person-outline" size={size} color={color} />
          ),
        }}
      /> */}
    </Tab.Navigator>
  );
}