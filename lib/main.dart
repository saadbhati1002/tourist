import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tourist/screen/splash/splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyCym2QnkvpdA4LQ-wPQdIzDNUF2AIx7B2c',
        appId: '1:104570725171:android:daf15260471a4f2c40d446',
        messagingSenderId: '104570725171',
        projectId: 'dubai-tourist',
        storageBucket: 'dubai-tourist.appspot.com',
        androidClientId:
            '475549178638-4n2hgqgn6mkgnjma33kv8lceb7s8g3vo.apps.googleusercontent.com',
        iosClientId:
            '104570725171-mj077noqeq8fer2ahph5du3gn4nvblkt.apps.googleusercontent.com',
        iosBundleId: 'com.tourist.vivah',
      ),
    );
  }

  HttpOverrides.global = MyHttpOverrides();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  NotificationsReceiving().disableAutomaticPushNotifications();

  NotificationsReceiving().initMessaging();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: FToastBuilder(),
      title: AppConstant.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "inter",
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
