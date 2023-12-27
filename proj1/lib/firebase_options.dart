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
    apiKey: 'AIzaSyDjulLrXpsJUlZq9m-j9T4mVUxWckdasL8',
    appId: '1:535100842132:web:6211ef7c20b10931b59481',
    messagingSenderId: '535100842132',
    projectId: 'shoppers-c153d',
    authDomain: 'shoppers-c153d.firebaseapp.com',
    storageBucket: 'shoppers-c153d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgmDDwHovsQiu7dO0TGJwAevf2iPKu4u0',
    appId: '1:535100842132:android:a439f47459d6dc70b59481',
    messagingSenderId: '535100842132',
    projectId: 'shoppers-c153d',
    storageBucket: 'shoppers-c153d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOb-AzPLOP1M7idR4eK7R5JrIku8vtUfs',
    appId: '1:535100842132:ios:e0cd1e24608f8e3cb59481',
    messagingSenderId: '535100842132',
    projectId: 'shoppers-c153d',
    storageBucket: 'shoppers-c153d.appspot.com',
    iosBundleId: 'com.example.shoppers',
  );
}
