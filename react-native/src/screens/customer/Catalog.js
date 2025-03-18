import React, { useState } from 'react';
import { StyleSheet, Text, View, TextInput, TouchableOpacity } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { TianguisColors } from '../../constants/TianguisColors';
import ItemCatalog from '../../components/CatalogItemsList';
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
        <Text style={styles.title}>Items Near Me</Text>
        {/*//TODO: temporal fix to center title xd */}
        <View></View>
      </View>

      {/*  Barra de búsqueda */}
      <SearchBar placeholder="Search"/>

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
 
});