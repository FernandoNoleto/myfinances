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
    apiKey: 'AIzaSyBoVzSByPt2ui_HzQZ1VdGEN8QFCXd9bTc',
    appId: '1:956330963816:web:4a6dbbd0e71b2b8b845cdd',
    messagingSenderId: '956330963816',
    projectId: 'myfinances-5d32a',
    authDomain: 'myfinances-5d32a.firebaseapp.com',
    databaseURL: 'https://myfinances-5d32a-default-rtdb.firebaseio.com',
    storageBucket: 'myfinances-5d32a.appspot.com',
    measurementId: 'G-Y6S1NM37QV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNQLCeJ5elNsGo-mt4ZQjHKokDwgq9r6E',
    appId: '1:956330963816:android:ef9caa1c9d1c1863845cdd',
    messagingSenderId: '956330963816',
    projectId: 'myfinances-5d32a',
    databaseURL: 'https://myfinances-5d32a-default-rtdb.firebaseio.com',
    storageBucket: 'myfinances-5d32a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRTU01SCCE2vWNbEKdekiMpw7NF2Xhboc',
    appId: '1:956330963816:ios:a386aeda8e454f2d845cdd',
    messagingSenderId: '956330963816',
    projectId: 'myfinances-5d32a',
    databaseURL: 'https://myfinances-5d32a-default-rtdb.firebaseio.com',
    storageBucket: 'myfinances-5d32a.appspot.com',
    iosBundleId: 'com.example.myfinances',
  );
}
