import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final userRepo = AuthMethod();
  Future<String> crateUser(BuildContext context, UserModel user) async {
    try {
      bool success = await userRepo.createUser(user);
      notifyListeners();
      return "success";
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
