import React, { useState, useEffect } from 'react';
import { StyleSheet, View, TouchableOpacity, Text, Alert } from 'react-native';
import { supabase } from '../../config/supabase';
import { TianguisColors } from '../../constants/TianguisColors';
import CatalogHeader from '../../components/CatalogHeader';
import CatalogItemsList from '../../components/CatalogItemsList';
import SearchBar from '../../components/SearchBar';

export default function MyItems({ navigation }) {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [activeFilter, setActiveFilter] = useState('available');

  useEffect(() => {
    fetchMyItems();
  }, []);

  const fetchMyItems = async () => {
    try {
      setLoading(true);
      // TODO: Replace with actual user ID from auth context
      const userId = 1; // temporary user ID

      const { data: items, error } = await supabase
        .from('item')
        .select(`
          id,
          name,
          price,
          selled,
          disable,
          created_at
        `)
        .eq('owner', userId)
        .eq('disable', false)
        .order('created_at', { ascending: false });

      if (error) throw error;

      const formattedItems = items.map(item => ({
        id: item.id.toString(),
        name: item.name,
        price: parseFloat(item.price),
        image: item.photo_url || '',
        state: item.selled ? 'sold' : 'available'
      }));

      setProducts(formattedItems);
    } catch (error) {
      Alert.alert('Error', error.message);
    } finally {
      setLoading(false);
    }
  };

  const filteredProducts = products.filter(product => product.state === activeFilter);

  return (
    <View style={styles.container}>
      <CatalogHeader 
        title="My Items"
        navigation={navigation}
        showBackButton={true}
        showAddButton={true}
        onAddPress={() => navigation.navigate('AddItem')}
      />

      <SearchBar placeholder="Search"/>

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

      <CatalogItemsList 
        navigation={navigation} 
        products={filteredProducts}
        loading={loading}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: TianguisColors.lightGrayBackground,
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