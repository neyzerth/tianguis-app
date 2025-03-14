import React, { useState } from 'react';
import { StyleSheet, Text, View, TextInput, Image, FlatList, TouchableOpacity, Pressable } from 'react-native';
import { Ionicons, MaterialIcons } from '@expo/vector-icons';

export default function MyItems({ navigation }) {
  const [products, setProducts] = useState([
    { id: '1', name: 'Lego Back to the future', price: 1200.00, image: '', category: 'available' },
    { id: '2', name: 'Lego Speed Ford', price: 1500.00, image: '', category: 'sold' },
    { id: '3', name: 'Lego Speed McLaren', price: 1300.00, image: '', category: 'available' },
    { id: '4', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', category: 'available' },
  ]);

  const [activeFilter, setActiveFilter] = useState('available');

  const filteredProducts = products.filter(product => product.category === activeFilter);

  const renderProduct = ({ item }) => (
    <View style={styles.productCard}>
      <Pressable onPress={() => navigation.push('Item')}>
        <Image
          source={{ uri: item.image }}
          style={styles.productImage}
        />
        <Text style={styles.productPrice}>${item.price.toFixed(2)}</Text>
        <Text style={styles.productName}>{item.name}</Text>
      </Pressable>
    </View>
  );

  return (
    <View style={styles.container}>
      {/* Header con botón de retroceso y título */}
      <View style={styles.header}>
        <TouchableOpacity style={styles.backButton}>
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

      {/* Barra de búsqueda */}
      <View style={styles.searchBar}>
        <Ionicons name="search" size={20} color="#999" style={styles.searchIcon} />
        <TextInput
          style={styles.searchInput}
          placeholder="Search"
          placeholderTextColor="#999"
        />
      </View>

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
      <FlatList
        data={filteredProducts}
        renderItem={renderProduct}
        keyExtractor={item => item.id}
        numColumns={2}
        contentContainerStyle={styles.productsList}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8f8f8',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingTop: 40,
    paddingBottom: 10,
    backgroundColor: '#fff',
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
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    marginHorizontal: 16,
    marginVertical: 10,
    paddingHorizontal: 10,
    height: 40,
  },
  searchIcon: {
    marginRight: 10,
  },
  searchInput: {
    flex: 1,
    height: 40,
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
    borderColor: '#ddd',
    backgroundColor: '#fff',
  },
  activeFilter: {
    backgroundColor: '#e8f5e9',
    borderColor: '#4caf50',
  },
  soldFilter: {
    backgroundColor: '#ffebee',
    borderColor: '#f44336',
  },
  filterText: {
    color: '#666',
  },
  activeFilterText: {
    color: '#4caf50',
    fontWeight: 'bold',
  },
  soldFilterText: {
    color: '#f44336',
    fontWeight: 'bold',
  },
  productsList: {
    paddingHorizontal: 8,
  },
  productCard: {
    flex: 1,
    backgroundColor: '#fff',
    borderRadius: 8,
    margin: 8,
    overflow: 'hidden',
  },
  productImage: {
    width: '100%',
    height: 150,
    resizeMode: 'cover',
  },
  productPrice: {
    fontSize: 16,
    fontWeight: 'bold',
    marginTop: 8,
    marginLeft: 8,
  },
  productName: {
    fontSize: 14,
    color: '#666',
    marginTop: 4,
    marginLeft: 8,
    marginBottom: 8,
  },
});