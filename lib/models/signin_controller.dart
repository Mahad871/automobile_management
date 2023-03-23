import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/models/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SignInController extends GetxController {
//   static SignInController get instance => Get.find();

// //TextFietd Controllers to get data from TextFieIds
//   final email = TextEditingController();
//   final username = TextEditingController();
//   final password = TextEditingController();
//   final confirmPassword = TextEditingController();

//   // final userRepo = Get.put(UserRepository());
//   final userRepo = UserRepositoryProvider();
//   signInUser({required String email, required String password}) async {
//     await userRepo.siginUser(email: email, password: password);
//   }
// }
class SignInController extends ChangeNotifier {
  static SignInController get instance => Get.find();

//TextFietd Controllers to get data from TextFieIds
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  // final userRepo = Get.put(UserRepository());
  final userRepo = UserRepositoryProvider();
  signInUser({required String email, required String password}) async {
    await userRepo.siginUser(email: email, password: password);
  }
}
