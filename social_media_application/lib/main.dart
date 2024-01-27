import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_application/api/firebase_api.dart';
import 'package:social_media_application/auth/auth.dart';
import 'package:social_media_application/auth/login_or_register.dart';
import 'package:social_media_application/firebase_options.dart';
import 'package:social_media_application/pages/home_page.dart';
import 'package:social_media_application/pages/notification_page.dart';
import 'package:social_media_application/pages/profile_page.dart';
import 'package:social_media_application/pages/users_page.dart';
import 'package:social_media_application/theme/light_mode.dart';
import 'package:social_media_application/theme/dark_mode.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      navigatorKey: navigatorKey,
      routes:
      {
        '/login_or_register_page' : (context) => const LoginOrRegister(),
        'home_page' : (context) => HomePage(),
        '/profile_page' : (context) => ProfilePage(),
        '/users_page' : (context) => const UserPage(),
        '/notification_screen' : (context) => const NotificationPage(),
      },
    );
  }
}