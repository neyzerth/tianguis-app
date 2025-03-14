import React from "react";
import { View, Pressable, Text, StyleSheet } from "react-native";

export default function TianguisButtonText(props) {
    const {text} = props;
    
    return(
        <View>
            <Pressable 
              style={styles.btn}>
                <Text style={styles.btnText}>{text}</Text>
            </Pressable>
        </View>
    );
}

const styles = StyleSheet.create({
  btn: {
    margin: 5,
    padding: 5,
    justifyContent: 'center',
  },
  btnText: {
    textAlign: 'center',
    color: '#aaa'
  }
});