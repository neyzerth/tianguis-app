import React from 'react';
import { Image, StyleSheet } from 'react-native';

function Logo({ source, size = 200 }) {
    return (
        <Image
            style={[styles.logo, { width: size }]}
            source={source}
            resizeMode="contain"
        />
    );
}

export function BlackLogo({ size = 200 }) {
    return (
        <Logo 
            source={require('../../assets/tianguis-black.png')}
            size={size}
        />
    );
}

export function WhiteLogo({ size = 200 }) {
    return (
        <Logo
            source={require('../../assets/tianguis-white.png')}
            size={size}
        />
    );
}

const styles = StyleSheet.create({
    logo: {
        height: undefined,
        aspectRatio: 1,
    }
});