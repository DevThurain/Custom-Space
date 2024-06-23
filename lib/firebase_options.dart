// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMiL-SN1NYgNcRT0QzliQ3xatqOQGa5V8',
    appId: '1:456232339408:android:54988adc6fa7453a47dbd5',
    messagingSenderId: '456232339408',
    projectId: 'photo-space-77cc7',
    storageBucket: 'photo-space-77cc7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrP7dgVStMEUXyT6AtvviFyTHgZnCLZGw',
    appId: '1:456232339408:ios:71c7b7ed54d8fd4847dbd5',
    messagingSenderId: '456232339408',
    projectId: 'photo-space-77cc7',
    storageBucket: 'photo-space-77cc7.appspot.com',
    androidClientId: '456232339408-59lpkk6npov2sbc3uht2tu9b8iebgfus.apps.googleusercontent.com',
    iosClientId: '456232339408-6ka8ogb41ego8a6345g7rj18cvn0ak92.apps.googleusercontent.com',
    iosBundleId: 'com.thurainx.photoSpace',
  );

}