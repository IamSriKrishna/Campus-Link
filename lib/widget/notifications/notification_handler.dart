import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static bool isOnChatScreen = false;

  static void setOnChatScreen(bool value) {
    isOnChatScreen = value;
  }

  // Define the variables at the class level
  static bool _isFlutterLocalNotificationsInitialized = false;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static late AndroidNotificationChannel _channel;

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Initialize Firebase in the background
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCishefTquUez42NWNNToO61QKxIomFJkE',
        appId: '1:879927221521:android:6c90c1bd25ebc4f4b1c0b0',
        messagingSenderId: '879927221521',
        projectId: 'campuslink-d1f2d',
      ),
    );

    // Initialize the notification plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('kcg');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Show the notification
    await showFlutterNotification(message);

    // Log background message handling
    debugPrint('Handling a background message from ${message.senderId}');
  }

  static Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) return;

    _channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    // Initialize the notification channel
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // Configure foreground notification options
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
        showFlutterNotification(message);
      }
    });

    _isFlutterLocalNotificationsInitialized = true;
  }

  static Future<void> showFlutterNotification(RemoteMessage message) async {
    if (isOnChatScreen) {
      debugPrint('User is on chat screen, suppressing notification');
      return;
    }
    RemoteNotification? notification = message.notification;
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'high_importance_channel', 'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            icon: 'kcg');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    if (notification != null) {
      await _flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        notificationDetails,
      );
    }
  }
}
