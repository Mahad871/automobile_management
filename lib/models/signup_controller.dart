import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/models/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpControtter extends GetxController {
  static SignUpControtter get instance => Get.find();

//TextFietd Controllers to get data from TextFieIds
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final userRepo = Get.put(UserRepository());

  crateUser(UserModel user) async {
    await userRepo.createUser(user);
  }
}
