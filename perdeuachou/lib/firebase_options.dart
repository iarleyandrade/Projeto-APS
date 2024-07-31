// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, prefer_double_quotes, public_member_api_docs
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
        return macos;
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
    // ignore: prefer_double_quotes
    apiKey: 'AIzaSyD7m-iOheQjwmGtxTKvmI2B2QYSLPWFdTI',
    appId: '1:149568471098:web:8c485ff23662c157b87503',
    messagingSenderId: '149568471098',
    projectId: 'perdeuachou-d67a9',
    authDomain: 'perdeuachou-d67a9.firebaseapp.com',
    databaseURL: 'https://perdeuachou-d67a9-default-rtdb.firebaseio.com',
    storageBucket: 'perdeuachou-d67a9.appspot.com',
    measurementId: 'G-6P0PFSWB66',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxBHlVm2fv0hFxJ_tE09AkeFPhdPBnaRg',
    appId: '1:149568471098:android:24290ac1a8e54ae3b87503',
    messagingSenderId: '149568471098',
    projectId: 'perdeuachou-d67a9',
    databaseURL: 'https://perdeuachou-d67a9-default-rtdb.firebaseio.com',
    storageBucket: 'perdeuachou-d67a9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoWCQzbY4uK9frcM1ipfj8kHL4tutva94',
    appId: '1:149568471098:ios:2ac6373b15d4bdb2b87503',
    messagingSenderId: '149568471098',
    projectId: 'perdeuachou-d67a9',
    databaseURL: 'https://perdeuachou-d67a9-default-rtdb.firebaseio.com',
    storageBucket: 'perdeuachou-d67a9.appspot.com',
    iosBundleId: 'com.example.perdeuachou',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoWCQzbY4uK9frcM1ipfj8kHL4tutva94',
    appId: '1:149568471098:ios:6b3eaf12600b7844b87503',
    messagingSenderId: '149568471098',
    projectId: 'perdeuachou-d67a9',
    databaseURL: 'https://perdeuachou-d67a9-default-rtdb.firebaseio.com',
    storageBucket: 'perdeuachou-d67a9.appspot.com',
    iosBundleId: 'com.example.perdeuachou.RunnerTests',
  );
}
