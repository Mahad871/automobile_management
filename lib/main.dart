import 'package:automobile_management/Screens/chat_list_page.dart';
import 'package:automobile_management/Screens/forget_password_screen.dart';
import 'package:automobile_management/Screens/notificastion_page.dart';
import 'package:automobile_management/Screens/registration_screen.dart';
import 'package:automobile_management/Screens/search_page.dart';
import 'package:automobile_management/Screens/update_password_screen.dart';
import 'package:flutter/material.dart';
import 'Screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
      // home: const LoginScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignInScreen(),
        '/login': (context) => const SignInScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/forget_password': (context) => const ForgetPasswordScreen(),
        '/update_password': (context) => const UpdatePasswowrdScreen(),
        '/chatlist': (context) => const ChatListScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/search': (context) => const SearchScreen(title: "Search"),
      },
    );
  }
}
