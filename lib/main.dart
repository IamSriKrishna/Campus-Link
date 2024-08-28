import 'dart:io';
import 'package:campuslink/Feature/Screen/Auth/Login.dart';
import 'package:campuslink/Feature/Screen/OnBoard/OnboardScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:campuslink/Constrains/ThemeStyle.dart';
import 'package:campuslink/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:campuslink/Feature/Service/Authservice.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Profile/Widget/LanguageContoller.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Provider/chat_provider.dart';
import 'package:campuslink/Util/LocalNotification.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:campuslink/route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCishefTquUez42NWNNToO61QKxIomFJkE',
          appId: '1:879927221521:android:6c90c1bd25ebc4f4b1c0b0',
          messagingSenderId: '879927221521',
          projectId: 'campuslink-d1f2d'));
  showFlutterNotification(message);
  print('Handling a background message ${message.senderId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) async {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  RemoteNotification? notification = message.notification;
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await _flutterLocalNotificationsPlugin.show(
    0,
    notification!.title,
    notification.body,
    notificationDetails,
  );

  isFlutterLocalNotificationsInitialized = true;
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: 'AIzaSyCishefTquUez42NWNNToO61QKxIomFJkE',
              appId: '1:879927221521:android:e890f086f7ad445eb1c0b0',
              messagingSenderId: '879927221521',
              projectId: 'campuslink-d1f2d'))
      : Firebase.initializeApp();
  await LocalNotifications.init();
  FirebaseMessaging.instance.getToken().then((value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('fcmToken', value!);
  });
  await SharedPreferences.getInstance();
  Get.put(LanguageController());
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showFlutterNotification(message);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => DarkThemeProvider(),
                child: MyApp(),
              ),
              ChangeNotifierProvider(
                create: (context) => StudentProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => ChatNotifier(),
              ),
            ],
            child: MyApp(),
          )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token = '';
  String locale = '';
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
    _loadToken();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });
    authService.getUserData(context);
    loadSelectedLanguage();
  }

  Future<void> loadSelectedLanguage() async {
    final pref =
        GetStorage(); // Use GetStorage to retrieve the selected language subcode
    setState(() {
      locale = pref.read('locale') ?? 'en';
    });
  }

  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('LoggedIn').toString();
    });
  }

  Future<void> _requestNotificationPermission() async {
    await Permission.notification.request();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Consumer<DarkThemeProvider>(
      builder: (context, darkThemeProvider, child) {
        return GetMaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          locale: Get.find<LanguageController>().getLocale(),
          supportedLocales: S.delegate.supportedLocales,
          theme: Styles().themeData(darkThemeProvider.getDarkTheme, context),
          debugShowCheckedModeBanner: false,
          home: token == 'Logged'
              ? OverScreen()
              : token == 'LoggedOut'
                  ? Login()
                  : OnBoardScreen(), // Show authenticated screen
          onGenerateRoute: (settings) => onGenerator(settings, locale),
        );
      },
    );
  }
}
