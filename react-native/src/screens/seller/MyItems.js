import React, { useState } from 'react';
import { StyleSheet, Text, View, TextInput, TouchableOpacity } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { TianguisColors } from '../../constants/TianguisColors';
import ItemCatalog from '../../components/ItemCatalog';
import SearchBar from '../../components/SearchBar';

export default function MyItems({ navigation }) {
  const products = [
    { id: '1', name: 'Lego Back to the future', price: 1200.00, image: '', state: 'available' },
    { id: '2', name: 'Lego Speed Ford', price: 1500.00, image: '', state: 'sold' },
    { id: '3', name: 'Lego Speed McLaren', price: 1300.00, image: '', state: 'available' },
    { id: '4', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available' },
    { id: '5', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available' },
    { id: '6', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available' },
    { id: '7', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available' },
    { id: '8', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available' },
    { id: '9', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available' },
    { id: '10', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available' },
];

  const [activeFilter, setActiveFilter] = useState('available');
 
  const filteredProducts = products.filter(product => product.state === activeFilter);

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Ionicons name="arrow-back" size={24} color="black" />
        </TouchableOpacity>
        <Text style={styles.title}>My Items</Text>
        <TouchableOpacity 
          style={styles.addButton}
          onPress={() => navigation.navigate('AddItem')}
        >
          <Ionicons name="add" size={24} color="black" />
        </TouchableOpacity>
      </View>

      {/*  Barra de búsqueda */}
      <SearchBar placeholder="Search"/>

      {/* Filtros */}
      <View style={styles.filterContainer}>
        <TouchableOpacity
          style={[
            styles.filterButton,
            activeFilter === 'available' && styles.activeFilter
          ]}
          onPress={() => setActiveFilter('available')}
        >
          <Text style={activeFilter === 'available' ? styles.activeFilterText : styles.filterText}>
            Available
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={[
            styles.filterButton,
            activeFilter === 'sold' && styles.soldFilter
          ]}
          onPress={() => setActiveFilter('sold')}
        >
          <Text style={activeFilter === 'sold' ? styles.soldFilterText : styles.filterText}>
            Sold
          </Text>
        </TouchableOpacity>
      </View>

      {/* Lista de productos */}
      <ItemCatalog navigation={navigation} products={filteredProducts} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: TianguisColors.lightGrayBackground,
  },
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
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  addButton: {
    padding: 5,
  },
  filterContainer: {
    flexDirection: 'row',
    paddingHorizontal: 16,
    marginBottom: 10,
  },
  filterButton: {
    paddingVertical: 8,
    paddingHorizontal: 16,
    borderRadius: 20,
    marginRight: 10,
    borderWidth: 1,
    borderColor: TianguisColors.grayBorder,
    backgroundColor: TianguisColors.background,
  },
  activeFilter: {
    backgroundColor: TianguisColors.greenBackground,
    borderColor: TianguisColors.greenBorder,
  },
  soldFilter: {
    backgroundColor: TianguisColors.redBackground,
    borderColor: TianguisColors.redBorder,
  },
  filterText: {
    color: TianguisColors.gray,
  },
  activeFilterText: {
    color: TianguisColors.greenText,
    fontWeight: 'bold',
  },
  soldFilterText: {
    color: TianguisColors.redText,
    fontWeight: 'bold',
  },
 
});