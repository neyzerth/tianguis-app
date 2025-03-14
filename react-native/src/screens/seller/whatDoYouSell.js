import React, {useEffect} from 'react';
import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View } from 'react-native';
import { ScrollView } from 'react-native-web';

export default function App() {
  return (
    <ScrollView>
        <Text></Text>
    </ScrollView>
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
    fontSize: 30
  },
  subtitle: {
    color: '#aaa',
    fontSize: 15
  },
});
