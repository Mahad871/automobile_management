import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final address = TextEditingController();
  final phoneNo = TextEditingController();
}
