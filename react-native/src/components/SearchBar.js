import React from 'react';
import { StyleSheet, View, TextInput } from 'react-native';
import { TianguisColors } from '../constants/TianguisColors';
import { Ionicons } from '@expo/vector-icons';

export default function SearchBar({placeholder="Search"}) {
    return(

        <View style={styles.searchBar}>
            <Ionicons name="search" size={20} color={TianguisColors.placeholder} style={styles.searchIcon} />
            <TextInput
            style={styles.searchInput}
            placeholder={placeholder}
            placeholderTextColor={TianguisColors.placeholder}
            />
        </View>
    );
   
}

const styles = StyleSheet.create({
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: TianguisColors.grayBox,
    borderRadius: 8,
    marginHorizontal: 16,
    marginVertical: 10,
    paddingHorizontal: 10,
    height: 40,
  },
  searchIcon: {
    marginRight: 10,
  },
  searchInput: {
    flex: 1,
    height: 40,
  },
});