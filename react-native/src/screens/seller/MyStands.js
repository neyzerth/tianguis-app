import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default function MyStands() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>My Stands</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  }
});