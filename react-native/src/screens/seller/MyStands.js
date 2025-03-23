import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View, TouchableOpacity, SafeAreaView, StatusBar } from 'react-native';
import { useNavigation, useRoute } from '@react-navigation/native';
import Icon from 'react-native-vector-icons/Feather';

export default function MyStands() {
  const navigation = useNavigation();
  const route = useRoute();
  const [stands, setStands] = useState([
    { id: '1', location: 'El Refugio', category: '' }
  ]);

  useEffect(() => {
    if (route.params?.newStand) {
      // Agregar el nuevo stand a la lista
      const newStand = {
        id: (stands.length + 1).toString(),
        location: route.params.newStand.location,
        category: route.params.newStand.category
      };
      setStands(prevStands => [...prevStands, newStand]);
      
      navigation.setParams({ newStand: undefined });
    }
  }, [route.params?.newStand]);

  const navigateToAddStand = () => {
    navigation.navigate('WhatDoYouSell');
  };

  return (
    <SafeAreaView style={styles.safeArea}>
      <StatusBar barStyle="dark-content" />
      <View style={styles.container}>
        {/* Header*/}
        <View style={styles.header}>
          <TouchableOpacity style={styles.backButton}>
            <Icon name="arrow-left" size={24} color="#000" />
          </TouchableOpacity>
          <Text style={styles.title}>My Stands</Text>
          <TouchableOpacity 
            style={styles.addButton}
            onPress={navigateToAddStand}
          >
            <Text style={styles.addButtonText}>Add</Text>
          </TouchableOpacity>
        </View>

        {/* Lista de stands */}
        <View style={styles.standsList}>
          {stands.map(stand => (
            <View key={stand.id} style={styles.standItem}>
              <Icon name="map-pin" size={20} color="#000" />
              <Text style={styles.standLocation}>{stand.location}</Text>
            </View>
          ))}
        </View>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#fff',
  },
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingTop: 10,
    paddingBottom: 15,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  backButton: {
    padding: 8,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  addButton: {
    backgroundColor: '#FF3B30',
    paddingVertical: 6,
    paddingHorizontal: 14,
    borderRadius: 16,
  },
  addButtonText: {
    color: 'white',
    fontWeight: 'bold',
  },
  standsList: {
    flex: 1,
    paddingTop: 15,
    paddingHorizontal: 20,
  },
  standItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
  },
  standLocation: {
    fontSize: 16,
    marginLeft: 10,
  },
});