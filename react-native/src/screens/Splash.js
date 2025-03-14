import { React } from "react";
import { View, Text, StyleSheet } from "react-native";
import { WhiteLogo } from "../components/Logo";
import { TianguisColors } from '../constants/TianguisColors';

export default function Splash() {
    return (
        <View style={styles.container}>
            <Text style={styles.text}>Tianguis App</Text>
            <WhiteLogo size={150} />
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: TianguisColors.red,
        alignItems: 'center',
        justifyContent: 'center',
        padding: 20
    },
    text: {
        color: 'white',
        fontSize: 32,
        fontWeight: 'bold',
        marginBottom: 20
    }
});
