import React, { useState } from 'react';
import { StyleSheet, View } from 'react-native';
import { TianguisColors } from '../../constants/TianguisColors';
import CatalogHeader from '../../components/CatalogHeader';
import ItemCatalog from '../../components/CatalogItemsList';
import SearchBar from '../../components/SearchBar';

export default function Catalog({ navigation }) {
  const [products, setProducts] = useState([
    { id: '1', name: 'Lego Back to the future', price: 1200.00, image: '', state: 'available', favorite: false },
    { id: '2', name: 'Lego Speed Ford', price: 1500.00, image: '', state: 'sold', favorite: true },
    { id: '3', name: 'Lego Speed McLaren', price: 1300.00, image: '', state: 'available', favorite: false  },
    { id: '4', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available', favorite: false  },
    { id: '5', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available', favorite: false  },
    { id: '6', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available', favorite: false  },
    { id: '7', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available', favorite: false  },
    { id: '8', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available', favorite: false  },
    { id: '9', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available', favorite: false  },
    { id: '10', name: 'Lego Speed Koenigsegg', price: 750.00, image: '', state: 'available', favorite: true },
  ]);

  const toggleFavorite = (id) => {
    setProducts(prevProducts => 
      prevProducts.map(product => 
        product.id === id 
          ? { ...product, favorite: !product.favorite }
          : product
      )
    );
  };

  return (
    <View style={styles.container}>
      <CatalogHeader 
        title="Items Near Me"
        navigation={navigation}
        showBackButton={true}
      />

      <SearchBar placeholder="Search"/>

      <ItemCatalog 
        navigation={navigation} 
        products={products} 
        onToggleFavorite={toggleFavorite}
        showFavorites={true}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: TianguisColors.lightGrayBackground,
  },
});