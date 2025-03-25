import React from "react";
import { StyleSheet, View, Text, Image } from "react-native";

export default function SavedProfile(props) {
    const {image, name} = props;
    
    return(
        <View style={styles.profile}>
            {/*Cambiar la ruta de la imagen para que sea dinámica*/}
            <Image
                source={require('../../assets/profilePictures/profile1.png')}
                style={styles.profileImage}
            />
            <Text style={styles.profileName}>{name}</Text>
        </View>
    );
}

const styles = StyleSheet.create({
    profile: {
        flexDirection: 'row',
        alignItems: 'center',
        width: '90%',
        marginVertical: 20,
    },
    profileImage: {
        width: 50,
        height: 50,
        resizeMode: 'cover',
        marginRight: 20
    },
    profileName: {
        fontSize: 15
    },
});