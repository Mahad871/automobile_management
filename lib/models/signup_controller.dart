import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/models/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SignUpController extends GetxController {
//   static SignUpController get instance => Get.find();

// //TextFietd Controllers to get data from TextFieIds
//   final email = TextEditingController();
//   final username = TextEditingController();
//   final password = TextEditingController();
//   final confirmPassword = TextEditingController();
//   final userRepo = Get.put(UserRepository());
//   // final userRepo = UserRepositoryProvider();
//   crateUser(UserModel user) async {
//     await userRepo.createUser(user);
//   }
// }
class SignUpController extends ChangeNotifier {
  // static SignUpController get instance => Get.find();

//TextFietd Controllers to get data from TextFieIds
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  // final userRepo = Get.put(UserRepository());

  final userRepo = UserRepositoryProvider();
  crateUser(UserModel user) async {
    await userRepo.createUser(user);
  }
}
