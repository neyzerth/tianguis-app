import React, { useState } from 'react';
import { StyleSheet, View } from 'react-native';
import { TianguisColors } from '../../constants/TianguisColors';
import CatalogHeader from '../../components/CatalogHeader';
import ItemCatalog from '../../components/CatalogItemsList';
import SearchBar from '../../components/SearchBar';

export default function Catalog({ navigation }) {
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
      <CatalogHeader 
        title="Items Near Me"
        navigation={navigation}
        showBackButton={true}
      />

      <SearchBar placeholder="Search"/>

      <ItemCatalog navigation={navigation} products={filteredProducts} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: TianguisColors.lightGrayBackground,
  },
});