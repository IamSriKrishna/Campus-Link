import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:campuslink/bloc/bloc_routes.dart';
import 'package:campuslink/widget/app/app_widget.dart';
import 'package:campuslink/widget/notifications/notification_handler.dart';
import 'package:campuslink/widget/service/firebase_service.dart';
import 'package:get_storage/get_storage.dart';
Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();
  await FirebaseService.requestNotificationPermission();
  FirebaseService.firebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(NotificationHandler.firebaseMessagingBackgroundHandler);
  await NotificationHandler.setupFlutterNotifications(); 
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(BlocRoute.router());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return AppWidget.myApp();
  }
}
