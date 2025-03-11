import React from "react";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { NavigationContainer } from "@react-navigation/native";
import { useNavigation } from "@react-navigation/native";


const MyItems = () => {

    const navigation = useNavigation();
    
    return (
        <view>
            <Text 
            style={{
                fontSize: 24,
                textAlign: "center",
                marginTop: '50%',
            }}
            >My Items </Text>
        </view>

    );
}

export default MyItems;