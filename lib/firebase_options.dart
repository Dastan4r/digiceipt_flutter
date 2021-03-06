// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBZorvFlC9tkwH3bCKIBc0Lpc3s27JLA5Q',
    appId: '1:617913004984:web:6fc4af43864fc1fd99d54d',
    messagingSenderId: '617913004984',
    projectId: 'mydigiceipts-android-ios',
    authDomain: 'mydigiceipts-android-ios.firebaseapp.com',
    storageBucket: 'mydigiceipts-android-ios.appspot.com',
    measurementId: 'G-FZL5347M6S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCq2VlqgagDVjFQdyy_z7uxQv3V1HoYU4M',
    appId: '1:617913004984:android:7e7a496ecbe7568a99d54d',
    messagingSenderId: '617913004984',
    projectId: 'mydigiceipts-android-ios',
    storageBucket: 'mydigiceipts-android-ios.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB557_Ht2z9iqPvKOpmrrxHtraizCJ833A',
    appId: '1:617913004984:ios:28a3c8125f2f725899d54d',
    messagingSenderId: '617913004984',
    projectId: 'mydigiceipts-android-ios',
    storageBucket: 'mydigiceipts-android-ios.appspot.com',
    androidClientId: '617913004984-25n16afrlfpcerol0o0iapc2m8qaluir.apps.googleusercontent.com',
    iosClientId: '617913004984-22hipidvp8n01ejl4c4p26kl3ss48bm4.apps.googleusercontent.com',
    iosBundleId: 'com.example.mydigiceiptsFlutter',
  );
}
