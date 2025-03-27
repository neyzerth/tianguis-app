import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { TianguisColors } from '../../constants/TianguisColors';
import CatalogItemsList from '../../components/CatalogItemsList';

export default function ItemsNearMe({ navigation }) {
  const items = [
    { 
      id: '1', 
      name: 'Vintage Car Model', 
      image: 'https://example.com/car.jpg', 
      price: 1200, 
      favorite: false 
    },
    { 
      id: '2', 
      name: 'Mechanical Keyboard', 
      image: 'https://example.com/keyboard.jpg', 
      price: 1500, 
      favorite: false 
    },
    { 
      id: '3', 
      name: 'BBQ Grill', 
      image: 'https://example.com/grill.jpg', 
      price: 800, 
      favorite: false 
    },
    { 
      id: '4', 
      name: 'Sneakers', 
      image: 'https://example.com/shoes.jpg', 
      price: 750, 
      favorite: false 
    },
    { 
      id: '5', 
      name: 'Game Controller', 
      image: 'https://example.com/controller.jpg', 
      price: 50, 
      favorite: false 
    },
    { 
      id: '6', 
      name: 'Leather Jacket', 
      image: 'https://example.com/jacket.jpg', 
      price: 100, 
      favorite: false 
    },
  ];

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Items Near Me</Text>
        <View style={styles.headerActions}>
          <View style={styles.searchBar}>
            <Ionicons name="search" size={20} color="gray" />
            <Text style={styles.searchText}>Search</Text>
          </View>
          <View style={styles.notificationIcon}>
            <Ionicons name="notifications-outline" size={24} color="black" />
          </View>
        </View>
      </View>

      <CatalogItemsList 
        navigation={navigation} 
        products={items} 
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: TianguisColors.lightGrayBackground,
  },
  header: {
    backgroundColor: TianguisColors.background,
    paddingTop: 40,
    paddingHorizontal: 15,
    paddingBottom: 15,
  },
  headerTitle: {
    fontSize: 22,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  headerActions: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: TianguisColors.lightGrayBackground,
    padding: 10,
    borderRadius: 10,
    flex: 1,
    marginRight: 10,
  },
  searchText: {
    marginLeft: 10,
    color: 'gray',
  },
  notificationIcon: {
    padding: 5,
  },
});