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
    apiKey: 'AIzaSyCCWZqgYw-Bz_EuI25ZsgMjlMU5mp1sjvE',
    appId: '1:71452735292:web:e4d721e9ec2e3e906f5039',
    messagingSenderId: '71452735292',
    projectId: 'spark-4d161',
    authDomain: 'spark-4d161.firebaseapp.com',
    storageBucket: 'spark-4d161.appspot.com',
    measurementId: 'G-JC8CL2950X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrd6Jyf5O56Gri6JJwtvC0Qezyv81O85Q',
    appId: '1:71452735292:android:27095c3c3c5fe06c6f5039',
    messagingSenderId: '71452735292',
    projectId: 'spark-4d161',
    storageBucket: 'spark-4d161.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9bshWa4uAh_FuCVV2YKfQrezHsHUowGg',
    appId: '1:71452735292:ios:1f56f2377c6691f66f5039',
    messagingSenderId: '71452735292',
    projectId: 'spark-4d161',
    storageBucket: 'spark-4d161.appspot.com',
    iosClientId: '71452735292-68jt7jndfgaahgfkgfbc1startlqj96v.apps.googleusercontent.com',
    iosBundleId: 'com.example.twitterClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD9bshWa4uAh_FuCVV2YKfQrezHsHUowGg',
    appId: '1:71452735292:ios:5a0f93950c3898ac6f5039',
    messagingSenderId: '71452735292',
    projectId: 'spark-4d161',
    storageBucket: 'spark-4d161.appspot.com',
    iosClientId: '71452735292-b22gl83qb1nilg05dj18je1kj0m537a0.apps.googleusercontent.com',
    iosBundleId: 'com.example.twitterClone.RunnerTests',
  );
}