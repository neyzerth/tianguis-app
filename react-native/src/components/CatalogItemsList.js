import React from 'react';
import { StyleSheet, Text, View, Image, FlatList, Pressable, Platform } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { TianguisColors } from '../constants/TianguisColors';

export default function ItemCatalog({ navigation, products, onToggleFavorite, showFavorites = false }) {
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
                <View style={styles.priceContainer}>
                    <Text style={styles.productPrice}>${item.price.toFixed(2)}</Text>
                    {showFavorites && (
                        <Pressable 
                            onPress={() => onToggleFavorite(item.id)}
                            style={({ pressed }) => [
                                styles.favoriteButton,
                                pressed && styles.pressed
                            ]}
                        >
                            <Ionicons 
                                name={item.favorite ? "heart" : "heart-outline"}
                                size={25}
                                color='black'
                                style={styles.favoriteIcon}
                            />
                        </Pressable>
                    )}
                </View>
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
  priceContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginTop: 8,
    marginLeft: 8,
  },
  favoriteIcon: {
    marginRight: 4,
  },
  productPrice: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  productName: {
    fontSize: 14,
    color: TianguisColors.gray,
    marginTop: 4,
    marginLeft: 8,
    marginBottom: 8,
  },
  favoriteButton: {
    padding: 8,
    marginRight: -4, // Compensa el padding
  },
  pressed: {
    opacity: 0.7,
  },
});