import React, { useState } from 'react';
import { StyleSheet, Text, View,FlatList } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import SavedProfile from '../../components/SavedProfile'; 


export default function MyItems({ navigation }) {
    const profiles = [
        { id: '1', name: "Andrés Cuevas", image: "profile1.png" },
        { id: '2', name: "María González", image: "profile2.png" },
        { id: '3', name: "Juan Pérez", image: "profile3.png" },
        { id: '4', name: "José Ramírez", image: "profile4.png" },
        { id: '5', name: "Ana Sánchez", image: "profile5.png" },
        { id: '6', name: "Miguel Torres", image: "profile1.png" },
        { id: '7', name: "Sofía Ruiz", image: "profile2.png" },
        { id: '8', name: "Fernando Herrera", image: "profile3.png" },
        { id: '9', name: "Lucía Morales", image: "profile4.png" },
        { id: '10', name: "Jabes Llamas", image: "profile5.png" },
    ];

  return (
    <View style={styles.container}>
        <View style={styles.header}>
            <Ionicons name="arrow-back" size={24} color="black" top={10} 
                onPress={() => navigation.goBack()}
            />
        </View>

        <Text style={styles.title}>Saved</Text>
        
        <FlatList
            data={profiles}
            keyExtractor={(item) => item.id}
            renderItem={({ item }) => (
                <SavedProfile 
                    image={item.image} 
                    name={item.name} 
                />
            )}
            contentContainerStyle={styles.listContainer}
        />
        
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8f8f8',
    alignItems: 'center',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingTop: 40,
    paddingBottom: 10,
    backgroundColor: '#fff',
    width: '95%'
  },
  title: {
    fontSize: 30,
    fontWeight: 'bold',
  },
  listContainer: {
    width: 350,
    paddingBottom: 20,
  },
});