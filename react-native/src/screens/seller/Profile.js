import React from 'react';
import { StyleSheet, Text, View, Image, TouchableOpacity, ScrollView } from 'react-native';
import { Ionicons } from '@expo/vector-icons';

export default function Profile() {
  // ejemplo
  const user = {
    firstName: 'Jack',
    lastName: 'Box',
    phone: '6648881559',
    email: 'jackbox@gmail.com',
    profileImage: 'https://via.placeholder.com/150'
  };

  return (
    <View style={styles.container}>
      {/* Header con título y botón de editar */}
      <View style={styles.header}>
        <TouchableOpacity style={styles.backButton}>
          <Ionicons name="arrow-back" size={24} color="black" />
        </TouchableOpacity>
        <Text style={styles.title}>Profile</Text>
        <TouchableOpacity style={styles.editButton}>
          <Text style={styles.editButtonText}>Edit</Text>
        </TouchableOpacity>
      </View>

      <ScrollView>
        {/* Foto de perfil y nombre */}
        <View style={styles.profileSection}>
          <Image
            source={{ uri: user.profileImage }}
            style={styles.profileImage}
          />
          <Text style={styles.userName}>{user.firstName} {user.lastName}</Text>
        </View>

        {/* Información del usuario */}
        <View style={styles.infoSection}>
          <View style={styles.infoField}>
            <Text style={styles.fieldLabel}>First name</Text>
            <Text style={styles.fieldValue}>{user.firstName}</Text>
          </View>
          
          <View style={styles.infoField}>
            <Text style={styles.fieldLabel}>Last name</Text>
            <Text style={styles.fieldValue}>{user.lastName}</Text>
          </View>
          
          <View style={styles.infoField}>
            <Text style={styles.fieldLabel}>Phone</Text>
            <Text style={styles.fieldValue}>{user.phone}</Text>
          </View>
          
          <View style={styles.infoField}>
            <Text style={styles.fieldLabel}>Email</Text>
            <Text style={styles.fieldValue}>{user.email}</Text>
          </View>
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
  editButton: {
    backgroundColor: '#f44336',
    paddingVertical: 6,
    paddingHorizontal: 16,
    borderRadius: 20,
  },
  editButtonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  profileSection: {
    alignItems: 'center',
    marginVertical: 20,
  },
  profileImage: {
    width: 120,
    height: 120,
    borderRadius: 60,
    marginBottom: 16,
  },
  userName: {
    fontSize: 22,
    fontWeight: 'bold',
  },
  infoSection: {
    marginHorizontal: 16,
  },
  infoField: {
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    padding: 16,
    marginBottom: 12,
  },
  fieldLabel: {
    fontSize: 14,
    color: '#888',
    marginBottom: 4,
  },
  fieldValue: {
    fontSize: 16,
    color: '#333',
  },
});