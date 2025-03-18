import React from 'react';
import { StyleSheet, Text, View, Image, FlatList, Pressable, Platform } from 'react-native';
import { TianguisColors } from '../constants/TianguisColors';

export default function ItemCatalog({ navigation, products }) {
    // Manejo diferente de imágenes para web y nativo
    const getImageSource = () => {
        if (Platform.OS === 'web') {
            return { uri: require('../../assets/item-default.png').uri };
        }
        return require('../../assets/item-default.png');
    };
    
    const renderProduct = ({ item }) => (
        <View style={styles.productCard}>
            <Pressable onPress={() => navigation.push('Item')}>
                <Image
                    source={item.image ? { uri: item.image } : getImageSource()}
                    style={styles.productImage}
                />
                <Text style={styles.productPrice}>${item.price.toFixed(2)}</Text>
                <Text style={styles.productName}>{item.name}</Text>
            </Pressable>
        </View>
    );

    return (
        <View style={styles.container}>
            <FlatList
                data={products}
                renderItem={renderProduct}
                keyExtractor={item => item.id}
                numColumns={2}
                contentContainerStyle={styles.productsList}
            />
        </View>
    );
}

const styles = StyleSheet.create({
  productsList: {
    paddingHorizontal: 8,
  },
  productCard: {
    flex: 1,
    backgroundColor: TianguisColors.background,
    borderRadius: 8,
    margin: 8,
    overflow: 'hidden',
  },
  productImage: {
    width: '100%',
    height: 150,
    resizeMode: 'contain',
  },
  productPrice: {
    fontSize: 16,
    fontWeight: 'bold',
    marginTop: 8,
    marginLeft: 8,
  },
  productName: {
    fontSize: 14,
    color: TianguisColors.gray,
    marginTop: 4,
    marginLeft: 8,
    marginBottom: 8,
  },
});