import React from 'react';
import { NativeModules } from 'react-native';
import { Button, View, StyleSheet, TouchableOpacity, Text } from 'react-native';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';

const {InAppModule} = NativeModules;
const Stack = createNativeStackNavigator();

const onPress = () => {
  InAppModule.launch(
    'https://your-domain.my.salesforce-scrt.com',
    'Your-Org-Id',
    'Your-Developer-Name',
    'Some-UUIDv4-String'
  );
};

const HomeScreen = ({navigation}) => {
  return (
    <View style={styles.container}>
      <Button
        title="Launch Chat"
        color="#841584"
        onPress={onPress}
      />
    </View>
  );
}

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
				<Stack.Screen
          name="Home"
          component={HomeScreen}
          options={{title: 'Welcome'}}
        	/>
      </Stack.Navigator>
    </NavigationContainer>
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
