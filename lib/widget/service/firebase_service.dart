import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async {
    // Return Future<void>
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCishefTquUez42NWNNToO61QKxIomFJkE',
          appId: '1:879927221521:android:e890f086f7ad445eb1c0b0',
          messagingSenderId: '879927221521',
          projectId: 'campuslink-d1f2d',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  }

  static void firebaseMessaging() {
    FirebaseMessaging.instance.getToken().then((value) async {
      if (value != null) {
        final box = GetStorage();
        box.write('firebase_token', value);
      }
    });
  }

  static Future<void> requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission for notifications
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }
}
