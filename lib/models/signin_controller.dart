import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:flutter/material.dart';

class SignInController extends ChangeNotifier {
//TextFietd Controllers to get data from TextFieIds
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  // final userRepo = Get.put(UserRepository());
  final userRepo = AuthMethod();
  signInUser({required String email, required String password}) async {
    await userRepo.siginUser(email: email, password: password);
  }
}
