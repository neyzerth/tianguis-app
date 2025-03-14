import React, {useEffect} from 'react';
import { StatusBar } from 'expo-status-bar';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { Searchbar } from 'react-native-paper';
import Icon from 'react-native-vector-icons/FontAwesome';
import Icon2 from 'react-native-vector-icons/Ionicons';
import Icon3 from 'react-native-vector-icons/MaterialCommunityIcons';
import Icon4 from 'react-native-vector-icons/Ionicons';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>What do you sell?</Text>
      
      <View style={styles.search}>
        <Searchbar
            placeholder="Search"
          />
      </View>
      
      <Text style={styles.heading}>Categories</Text>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon 
              name="soccer-ball-o"
              size={30}
            />
            <Text style={styles.categoryText}>Sports</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon2
              name="shirt-outline"
              size={28}
            />
            <Text style={styles.categoryText}>Clothes</Text>
        </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon3
              name="toy-brick-outline"
              size={30}
            />
            <Text style={styles.categoryText}>Toys</Text>
      </View>
      </Pressable>

      <Pressable onPress={() => {    }}>
        <View style={styles.category}>
            <Icon4 
              name="game-controller-outline"
              size={30}
            />
            <Text style={styles.categoryText}>Videogames</Text>
        </View>
      </Pressable>


      <Pressable onPress={() => {    }}>
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
