import React, {useEffect} from 'react';
import { StatusBar } from 'expo-status-bar';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { Searchbar } from 'react-native-paper';
import Icon from 'react-native-vector-icons/Feather';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Where do you sell?</Text>
      
      <View style={styles.search}>
        <Searchbar
            placeholder="Search"
          />
      </View>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon
              name="eye"
              size={30}
            />
            <Text style={styles.categoryText}>View in map</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon
              name="map-pin"
              size={30}
            />
            <Text style={styles.categoryText}>El Refugio</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon
              name="map-pin"
              size={30}
            />
            <Text style={styles.categoryText}>Valle verde</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon
              name="map-pin"
              size={30}
            />
            <Text style={styles.categoryText}>Otay</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon
              name="map-pin"
              size={30}
            />
            <Text style={styles.categoryText}>Las Torres</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon
              name="map-pin"
              size={30}
            />
            <Text style={styles.categoryText}>Villa del sol</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon
              name="map-pin"
              size={30}
            />
            <Text style={styles.categoryText}>Riveras del bosque</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
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
    top: 50
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
