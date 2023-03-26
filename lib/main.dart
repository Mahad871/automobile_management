import 'package:automobile_management/Screens/chat_list_page.dart';
import 'package:automobile_management/Screens/forget_password_screen.dart';
import 'package:automobile_management/Screens/notificastion_page.dart';
import 'package:automobile_management/Screens/signup_screen.dart';
import 'package:automobile_management/Screens/search_page.dart';
import 'package:automobile_management/Screens/update_password_screen.dart';
import 'package:automobile_management/models/profile_controller.dart';
import 'package:automobile_management/models/signin_controller.dart';
import 'package:automobile_management/models/signup_controller.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/firebase_storage_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'Common/constants.dart';
import 'Screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/storage_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  // GetStorage().writeIfNull('isLogged', false);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => AuthMethod()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => SignInController()),
        ChangeNotifierProvider(create: (_) => FirebaseStorageModel()),
        ChangeNotifierProvider(create: (_) => StorageProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.black,
            secondary: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: storage.read('isLoggedin') == false
            ? Text(storage.read('user').toString())
            : const SignInScreen(),
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
      ),
    );
  }
}
