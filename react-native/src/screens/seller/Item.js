import React, { useState } from 'react';
import { StyleSheet, Text, View, Image, Pressable } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useRoute } from '@react-navigation/native';

export default function MyItems({ navigation }) {
  const route = useRoute();
  const { item } = route.params || {};
  
  const [name, setName] = useState(item?.name || '');
  const [description, setDescription] = useState(item?.description || '');
  const [price, setPrice] = useState(item?.price || '');
  const [status, setStatus] = useState(item?.status || '');
  const [category, setCategory] = useState(item?.category || '');
  const [photo, setPhoto] = useState('');

  const itemData = {
    name: name,
    price: price,
    description: description,
    status: status,
    category: category,
    photo: photo,
  };

  return (
    <View style={styles.container}>
        <View style={styles.header}>
            <Ionicons name="arrow-back" size={24} color="black" top={10} 
                onPress={() => navigation.goBack()}
            />
        </View>
        <Image
            source={require('../../assets/images/delorean.jpg')}
            style={styles.productImage}
        />
        <View style={styles.info}>
            <Text style={styles.productPrice}>${price}</Text>
            <Text style={styles.productName}>{name}</Text>
        </View>

        <View style={styles.actionButtons}>
            <Pressable 
                  style={styles.buttonSell}
                  onPress={()=>{}}
                >
                  <Text style={styles.buttonText}>Sell</Text>
            </Pressable>

            <Pressable 
                  style={styles.buttonDelete}
                  onPress={()=>{}}
                >
                  <Text style={styles.buttonText}>Delete</Text>
            </Pressable>
        </View>

        <Pressable onPress={() => navigation.push('Saved')}>
            <View style={styles.actionText}>
                <Text>Saved</Text>
                <Text style={styles.savedCount}>32</Text>
            </View>
        </Pressable>
        
        <Pressable onPress={() => navigation.push('EditItem', {item:itemData})}>
            <View style={styles.actionText}>
                <Text>Edit Information</Text>
                <Ionicons name="chevron-forward" color="black" 
                />
            </View>
        </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8f8f8',
    alignItems: 'center',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingTop: 40,
    paddingBottom: 10,
    backgroundColor: '#fff',
    width: '95%'
  },
  productImage: {
    width: '100%',
    height: '50%',
    resizeMode: 'cover',
  },
  info: {
    width: '90%',
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
  actionButtons:{
    flexDirection: 'row',
    width: '90%',
    justifyContent: 'center',
  },
  actionText: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    width: '90%',
    marginVertical: 20,
  },
    buttonSell: {
        height: 50,
        width: '50%',
        margin: 12,
        borderRadius: 15,
        padding: 10,
        justifyContent: 'center',
        backgroundColor: '#81C784'
    },
    buttonDelete: {
        height: 50,
        width: '50%',
        margin: 12,
        borderRadius: 15,
        padding: 10,
        justifyContent: 'center',
        backgroundColor: '#E57373'
    },
    buttonText: {
        textAlign: 'center',
        color: '#fff',
        fontWeight: 'bold'
    },
});