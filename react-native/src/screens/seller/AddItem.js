import React, { useState } from 'react';
import { StyleSheet, Text, View, TextInput, TouchableOpacity, Image, ScrollView } from 'react-native';
import { Ionicons } from '@expo/vector-icons';

export default function AddItem({ navigation }) {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [price, setPrice] = useState('');
  const [status, setStatus] = useState('');
  const [category, setCategory] = useState('');
  const [photo, setPhoto] = useState(null);

  const handleSave = () => {
    console.log('Guardando nuevo item:', { name, description, price, status, category });
    
    navigation.goBack();
  };

  const handleUploadPhoto = () => {
   
    console.log('Subiendo foto');
  };

  return (
    <View style={styles.container}>
      {/* Header con botón de retroceso y título */}
      <View style={styles.header}>
        <TouchableOpacity style={styles.backButton} onPress={() => navigation.goBack()}>
          <Ionicons name="arrow-back" size={24} color="black" />
        </TouchableOpacity>
        <Text style={styles.title}>Add Item</Text>
        <TouchableOpacity style={styles.saveButton} onPress={handleSave}>
          <Ionicons name="add" size={24} color="black" />
        </TouchableOpacity>
      </View>

      <ScrollView style={styles.formContainer}>
        {/* Sección de foto */}
        <View style={styles.photoSection}>
          <TouchableOpacity style={styles.photoUpload} onPress={handleUploadPhoto}>
            {photo ? (
              <Image source={{ uri: photo }} style={styles.uploadedPhoto} />
            ) : (
              <>
                <View style={styles.photoPlaceholder}>
                  <Ionicons name="camera-outline" size={28} color="#666" />
                </View>
                <Text style={styles.uploadText}>Upload photo</Text>
              </>
            )}
          </TouchableOpacity>
        </View>

        {/* Campos del formulario */}
        <View style={styles.inputContainer}>
          <Text style={styles.inputLabel}>Name</Text>
          <TextInput
            style={styles.input}
            value={name}
            onChangeText={setName}
            placeholder=""
          />
        </View>

        <View style={styles.inputContainer}>
          <Text style={styles.inputLabel}>Description</Text>
          <TextInput
            style={styles.input}
            value={description}
            onChangeText={setDescription}
            placeholder=""
            multiline
          />
        </View>

        <View style={styles.inputContainer}>
          <Text style={styles.inputLabel}>Price</Text>
          <TextInput
            style={styles.input}
            value={price}
            onChangeText={setPrice}
            placeholder=""
            keyboardType="numeric"
          />
        </View>

        <View style={styles.inputContainer}>
          <Text style={styles.inputLabel}>Status</Text>
          <TextInput
            style={styles.input}
            value={status}
            onChangeText={setStatus}
            placeholder=""
          />
        </View>

        <View style={styles.inputContainer}>
          <Text style={styles.inputLabel}>Category</Text>
          <TextInput
            style={styles.input}
            value={category}
            onChangeText={setCategory}
            placeholder=""
          />
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8f8f8',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingTop: 40,
    paddingBottom: 10,
    backgroundColor: '#fff',
  },
  backButton: {
    padding: 5,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  saveButton: {
    padding: 5,
  },
  formContainer: {
    flex: 1,
    padding: 16,
  },
  photoSection: {
    alignItems: 'center',
    marginVertical: 20,
  },
  photoUpload: {
    alignItems: 'center',
  },
  photoPlaceholder: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
  },
  uploadedPhoto: {
    width: 150,
    height: 150,
    borderRadius: 75,
  },
  uploadText: {
    marginTop: 8,
    color: '#666',
    fontSize: 16,
  },
  inputContainer: {
    marginBottom: 16,
  },
  inputLabel: {
    fontSize: 14,
    color: '#888',
    marginBottom: 4,
  },
  input: {
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    padding: 16,
    fontSize: 16,
  },
});