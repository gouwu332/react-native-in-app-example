import * as reactNative from 'react-native';
// ...
const emitter: reactNative.EventEmitter =
  reactNative.Platform.OS === 'ios'
    ? new reactNative.NativeEventEmitter(
        reactNative.NativeModules.EventEmitter
      )
    : reactNative.DeviceEventEmitter;

export default emitter;