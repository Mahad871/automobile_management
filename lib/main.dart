import 'package:automobile_management/databases/notification_service.dart';
import 'package:automobile_management/providers/user/user_provider.dart';
import 'package:automobile_management/services/location_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'Screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dependency_injection/injection_container.dart';

Future<void> _firebaseMessBackgroundHand(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  if (notification == null) return;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await init();
  sl.get<UserProvider>().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessBackgroundHand);
  await NotificationsServices.init();
  try {
    await sl.get<LocationApi>().determinePosition();
  } on Exception catch (e) {}
  // sl.get<UserProvider>().refresh();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.white,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: SignInScreen()

      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const SignInScreen(),
      //   '/login': (context) => const SignInScreen(),
      //   '/register': (context) => const RegistrationScreen(),
      //   '/forget_password': (context) => const ForgetPasswordScreen(),
      //   '/update_password': (context) => const UpdatePasswowrdScreen(),
      //   '/chatlist': (context) => const ChatListScreen(),
      //   '/notification': (context) => const NotificationScreen(),
      //   '/search': (context) => const SearchScreen(title: "Search"),
      // },
    );
  }
}
