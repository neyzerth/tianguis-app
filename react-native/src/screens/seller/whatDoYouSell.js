import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { Pressable, StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import { Searchbar } from 'react-native-paper';
import { useNavigation } from '@react-navigation/native';
import Icon from 'react-native-vector-icons/FontAwesome';
import Icon2 from 'react-native-vector-icons/Ionicons';
import Icon3 from 'react-native-vector-icons/MaterialCommunityIcons';
import Icon4 from 'react-native-vector-icons/Ionicons';

export default function WhatDoYouSell() {
  const navigation = useNavigation();

  const navigateToNextScreen = (category) => {
    navigation.navigate('WhereDoYouSell', { category });
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Icon4 name="arrow-back" size={24} color="#000" />
        </TouchableOpacity>
      </View>
      
      <Text style={styles.title}>What do you sell?</Text>
      
      <View style={styles.search}>
        <Searchbar
          placeholder="Search"
        />
      </View>
      
      <Text style={styles.heading}>Categories</Text>

      <Pressable onPress={() => navigateToNextScreen('Sports')}>
        <View style={styles.category}>
          <Icon 
            name="soccer-ball-o"
            size={30}
          />
          <Text style={styles.categoryText}>Sports</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => navigateToNextScreen('Clothes')}>
        <View style={styles.category}>
          <Icon2
            name="shirt-outline"
            size={28}
          />
          <Text style={styles.categoryText}>Clothes</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => navigateToNextScreen('Toys')}>
        <View style={styles.category}>
          <Icon3
            name="toy-brick-outline"
            size={30}
          />
          <Text style={styles.categoryText}>Toys</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => navigateToNextScreen('Videogames')}>
        <View style={styles.category}>
          <Icon4 
            name="game-controller-outline"
            size={30}
          />
          <Text style={styles.categoryText}>Videogames</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => navigateToNextScreen('Others')}>
        <View style={styles.category}>
          <Icon4 
            name="ellipsis-horizontal-circle"
            size={30}
          />
          <Text style={styles.categoryText}>Others</Text>
        </View>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    paddingTop: 50
  },
  header: {
    width: '100%',
    flexDirection: 'row',
    paddingHorizontal: 16,
    marginBottom: 10,
  },
  backButton: {
    padding: 8,
  },
  title: {
    fontSize: 40,
    margin: 20
  },
  search: {
    width: 400,
    margin: 20
  },
  heading: {
    color: '#111',
    fontSize: 30,
    textAlign: 'left',
    fontWeight: 'bold',
    width: 400,
    margin: 10
  },
  category: {
    width: 400,
    height: 50,
    margin: 10,
    flexDirection: 'row',
    alignItems: 'center'
  },
  categoryText: {
    fontSize: 25,
    marginLeft: 20
  }
});