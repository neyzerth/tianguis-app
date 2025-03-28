import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { Pressable, StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import { Searchbar } from 'react-native-paper';
import { useNavigation, useRoute } from '@react-navigation/native';
import Icon from 'react-native-vector-icons/Feather';
import Icon2 from 'react-native-vector-icons/Ionicons';

export default function WhereDoYouSell() {
  const navigation = useNavigation();
  const route = useRoute();
  const category = route.params?.category || 'Category';

  const createStand = (location) => {
    navigation.navigate('StandsHome', {
      newStand: {
        category: category,
        location: location
      }
    });
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Icon2 name="arrow-back" size={24} color="#000" />
        </TouchableOpacity>
      </View>
      
      <Text style={styles.title}>Where do you sell?</Text>
      
      <View style={styles.search}>
        <Searchbar
          placeholder="Search"
        />
      </View>

      <Pressable onPress={() => { }}>
        <View style={styles.category}>
          <Icon
            name="eye"
            size={30}
          />
          <Text style={styles.categoryText}>View in map</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => createStand('El Refugio')}>
        <View style={styles.category}>
          <Icon
            name="map-pin"
            size={30}
          />
          <Text style={styles.categoryText}>El Refugio</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => createStand('Valle verde')}>
        <View style={styles.category}>
          <Icon
            name="map-pin"
            size={30}
          />
          <Text style={styles.categoryText}>Valle verde</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => createStand('Otay')}>
        <View style={styles.category}>
          <Icon
            name="map-pin"
            size={30}
          />
          <Text style={styles.categoryText}>Otay</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => createStand('Las Torres')}>
        <View style={styles.category}>
          <Icon
            name="map-pin"
            size={30}
          />
          <Text style={styles.categoryText}>Las Torres</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => createStand('Villa del sol')}>
        <View style={styles.category}>
          <Icon
            name="map-pin"
            size={30}
          />
          <Text style={styles.categoryText}>Villa del sol</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => createStand('Riveras del bosque')}>
        <View style={styles.category}>
          <Icon
            name="map-pin"
            size={30}
          />
          <Text style={styles.categoryText}>Riveras del bosque</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => { }}>
        <View style={styles.category}>
          <Icon
            name="plus-circle"
            size={30}
          />
          <Text style={styles.categoryText}>Add Tianguis</Text>
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