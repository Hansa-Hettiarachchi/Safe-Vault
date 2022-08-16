import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com_project/auth_controller.dart';
import 'package:com_project/loging_page.dart';
import 'package:com_project/signup_page.dart';
import 'package:com_project/splash_screen.dart';
import 'package:com_project/welcome-page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
      'resource://drawable/notification_icon',
      [            // notification icon
        NotificationChannel(
          channelGroupKey: 'basic_test',
          channelKey: 'basic',
          defaultColor: Colors.red,
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: true,
          importance: NotificationImportance.High,
          enableVibration: true,
          ledColor: Colors.red,
        ),
      ]
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Email And Password Login',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

