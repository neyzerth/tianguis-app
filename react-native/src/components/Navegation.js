import React from "react"; 
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { NavigationContainer } from "@react-navigation/native";
import {CreateNativeStackNavigator} from "@react-navigation/native-stack";

//icons
import MaterialCommunityIcons from '@expo/vector-icons/MaterialCommunityIcons';
import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import Ionicons from '@expo/vector-icons/Ionicons';

//Screens
import MyItems from "../screens/seller/MyItems";
import MyStands from "../screens/seller/MyStands";
import Profile from "../screens/seller/Profile";

const SellerStack = CreateNativeStackNavigator();

function MyStack(){
    return (
        <SellerStack.Navigator
            initialRouteName="MyItems"
            >
            <SellerStack.Screen
                name="items"
                component={MyItems}
                options={{title: "My Items"}}
            />
            <SellerStack.Screen
                name="stands"
                component={MyStands}
                options={{title: "My Stands"}}
            />
            <SellerStack.Screen
                name="Prof"
                component={Profile}
                options={{title: "Profile"}}
            />
        </SellerStack.Navigator>
    );
}

const Tab = createBottomTabNavigator();

function MyTabs(){
    return (
        <Tab.Navigator
            initialRouteName="Login"// Primera pantalla que se muestra cuando abre la app
            tabBarOptions={{
                activeTintColor: "#857b7b", //color de la tab que este seleccionada

            }}

            >
            <Tab.Screen
                name="MyItems"
                component={MyItems}
                options={{
                    tabBarIcon: ({color, size}) => (
                        <MaterialCommunityIcons name="shopping-outline" size={24} color="black" />
                    ), 
                    // tabBarBadge: 3, este funciona para ponerle una notificacion en la tab
                    // headerShown: false, oculta el header
                }}
            />
                

            <Tab.Screen 
                name="MyStands" 
                component={MyStack}
                options={{
                    tabBarIcon: ({color, size}) => (
                        <MaterialIcons name="storefront" size={24} color="black" />
                    ), 
                }}/>

            <Tab.Screen
             name="Profile"
             component={MyStack}
             options={{
                tabBarIcon: ({color, size}) => (
                    <Ionicons name="person-outline" size={24} color="black" />
                ),
             }}
             />
        </Tab.Navigator>
    );
}

export default function App() {
    return (
        <NavigationContainer>
            <MyTabs/>
        </NavigationContainer>
    );
}