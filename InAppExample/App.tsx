import React from 'react';
import { NativeModules } from 'react-native';
import { Button, View, StyleSheet, TouchableOpacity, Text } from 'react-native';

const {InAppModule} = NativeModules;

const onPress = () => {
  InAppModule.launch();
};

const App = () => {
  return (
    <View style={styles.container}>
      <Button
        title="Launch Chat"
        color="#841584"
        onPress={onPress}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'white'
  },
  button: {
    backgroundColor: 'blue',
    padding: 10,
    borderRadius: 5,
  },
  buttonText: {
    color: 'white',
    fontSize: 18,
  },
});

export default App;
