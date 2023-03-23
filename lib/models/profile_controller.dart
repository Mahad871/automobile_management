import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final address = TextEditingController();
  final phoneNo = TextEditingController();
}
