import React from "react";
import { View, Pressable, Text, StyleSheet } from "react-native";

export default function TianguisButton(props) {
    const {text, color} = props;
    
    return(
        <View>
            <Pressable style={styles.btn} backgroundColor={color}>
                <Text style={styles.btnText}>{text}</Text>
            </Pressable>
        </View>
    );
}

const styles = StyleSheet.create({
    btn: {
        height: 50,
        width: 350,
        margin: 12,
        borderRadius: 15,
        padding: 10,
        justifyContent: 'center',
    },
    btnText: {
      textAlign: 'center',
      color: '#fff',
      fontWeight: 'bold'
    }
});