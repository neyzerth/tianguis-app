import React, {useState, useEffect} from 'react';
import { StyleSheet, Text, View, Image, TouchableOpacity, ScrollView } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { supabase } from '../../config/supabase';

export default function Profile({ navigation, route }) {
  
  const [loading, setLoading] = useState(true);
  const [userData, setUserData] = useState({
    id: route.params?.userId,
    firstName: '',
    lastName: '',
    phone: '',
    email: '',
    avatar: ''
  });

  const fetchUserData = async () => {
    try {
      setLoading(true);
      
      const { data: user, error } = await supabase
        .from('user')
        .select('*')
        .eq('id', userData.id)
        .single();

      if (error) throw error;

      if (user) {
        const avatarUrl = 'https://maimcwzoauqmeswhzyah.supabase.co/storage/v1/object/public/photos/avatar/profile';
        
        setUserData({
          id: user.id,
          firstName: user.first_name,
          lastName: user.last_name,
          phone: user.phone,
          email: user.email,
          avatar: avatarUrl + user.avatar + '.png' 
        });
      }
    } catch (error) {
      Alert.alert('Error', error.message);
      console.error('Error fetching user data:', error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  useEffect(() => {
    fetchUserData();
    
    // Recargar datos cuando la pantalla recibe foco
    const unsubscribe = navigation.addListener('focus', () => {
      fetchUserData();
    });

    return unsubscribe;
  }, [navigation]);

  if (loading) {
    return (
      <View style={[styles.container, { justifyContent: 'center', alignItems: 'center' }]}>
        <Text>Loading...</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      {/* Header con título y botón de editar */}
      <View style={styles.header}>
        <TouchableOpacity style={styles.backButton}>
          <Ionicons name="arrow-back" size={24} color="black" />
        </TouchableOpacity>
        <Text style={styles.title}>Profile</Text>
        <TouchableOpacity style={styles.editButton}
          onPress={() => navigation.navigate('EditProfile', { userData })}>
          <Text style={styles.editButtonText}>Edit</Text>
        </TouchableOpacity>
      </View>

      <ScrollView>
        {/* Foto de perfil y nombre */}
        <View style={styles.profileSection}>
          <Image
            source={{ uri: userData.avatar }}
            style={styles.profileImage}
          />
          <Text style={styles.userName}>{userData.firstName} {userData.lastName}</Text>
        </View>

        {/* Información del usuario */}
        <View style={styles.infoSection}>
          <View style={styles.infoField}>
            <Text style={styles.fieldLabel}>First name</Text>
            <Text style={styles.fieldValue}>{userData.firstName}</Text>
          </View>
          
          <View style={styles.infoField}>
            <Text style={styles.fieldLabel}>Last name</Text>
            <Text style={styles.fieldValue}>{userData.lastName}</Text>
          </View>
          
          <View style={styles.infoField}>
            <Text style={styles.fieldLabel}>Phone</Text>
            <Text style={styles.fieldValue}>{userData.phone}</Text>
          </View>
          
          <View style={styles.infoField}>
            <Text style={styles.fieldLabel}>Email</Text>
            <Text style={styles.fieldValue}>{userData.email}</Text>
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