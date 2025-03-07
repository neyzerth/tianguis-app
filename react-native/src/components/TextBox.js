import React from "react";
import { View, StyleSheet, TextInput } from "react-native";

export default function TianguisButton(props) {
    const {placeholder, keyboardType, secureText} = props;
    
    return(
        <View>
            <TextInput
                style={styles.input}
                placeholder={placeholder}
                keyboardType={keyboardType}
                secureTextEntry={secureText}
            />
        </View>
    );
}

const styles = StyleSheet.create({
    input: {
        height: 50,
        width: 350,
        margin: 12,
        borderRadius: 10,
        padding: 10,
        backgroundColor: '#f5f5f5'
    }
});