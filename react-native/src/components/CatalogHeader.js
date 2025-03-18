import React from 'react';
import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { TianguisColors } from '../constants/TianguisColors';

export default function CatalogHeader({ 
    title = "Catalog",
    navigation,
    showBackButton = true,
    showAddButton = false,
    onAddPress
}) {
    return (
        <View style={styles.header}>
            {showBackButton ? (
                <TouchableOpacity 
                    style={styles.backButton}
                    onPress={() => navigation.goBack()}
                >
                    <Ionicons name="arrow-back" size={24} color="black" />
                </TouchableOpacity>
            ) : <View style={styles.placeholder} />}

            <Text style={styles.title}>{title}</Text>

            {showAddButton ? (
                <TouchableOpacity 
                    style={styles.addButton}
                    onPress={onAddPress}
                >
                    <Ionicons name="add" size={24} color="black" />
                </TouchableOpacity>
            ) : (
                <View style={styles.placeholder} />
            )}
        </View>
    );
}

const styles = StyleSheet.create({
    header: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingHorizontal: 16,
        paddingTop: 40,
        paddingBottom: 10,
        backgroundColor: TianguisColors.background,
    },
    backButton: {
        padding: 5,
        width: 34,
    },
    title: {
        fontSize: 20,
        fontWeight: 'bold',
    },
    addButton: {
        padding: 5,
        width: 34,
    },
    placeholder: {
        width: 34,
    }
});