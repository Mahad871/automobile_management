import 'package:automobile_management/Screens/home_page.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/providers/user/user_provider.dart';
import 'package:automobile_management/services/location_api.dart';
import 'package:automobile_management/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'Common/constants.dart';
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
  FirebaseMessaging.onBackgroundMessage(_firebaseMessBackgroundHand);
  NotificationsServices.init();
  await init();
  await sl.get<LocationApi>().determinePosition();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _storage = GetStorage();
  late var val;

  Future<bool> checkLoginStatus() async {
    val = null;
    val = _storage.read('user');
    print("Storage read result: $val");
    // print(val['email']);
    // _storage.erase();
    if (val == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.black,
              secondary: Colors.white,
            ),
          ),

          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: checkLoginStatus(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false || val == null) {
                return const SignInScreen();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SafeArea(
                  child: Container(
                    color: Colors.white,
                    child: const Center(
                        child: CircularProgressIndicator(color: textColor)),
                  ),
                );
              }
              AuthMethod authMethod = sl.get<AuthMethod>();

              if (authMethod.currentUser == null) {
                authMethod.signinUser(
                    email: val['email'].toString(),
                    password: val['password'].toString());
                authMethod.getCurrentUserData(val['email'].toString());
              }

              return const HomeScreen();
            },
          ),

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
        ));
  }
}
