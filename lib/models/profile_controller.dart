import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/models/user_repository.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ProfileController extends GetxController {
//   static ProfileController get instance => Get.find();

// //TextFietd Controllers to get data from TextFieIds
//   final email = TextEditingController();
//   final username = TextEditingController();
//   final password = TextEditingController();
//   final phoneNo = TextEditingController();
//   final address = TextEditingController();

//   final userRepo = Get.put(UserRepository());

//   updateUser(UserModel user) async {
//     await userRepo.updateUserData(user);
//     userRepo.updateUser(user: user);
//   }
// }
class ProfileProvider extends ChangeNotifier {
  // static ProfileProvider get instance => Get.find();

//TextFietd Controllers to get data from TextFieIds
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNo = TextEditingController();
  final address = TextEditingController();
  final userRepo = UserRepositoryProvider();
  // final userRepo = Get.put(UserRepository());

  updateUser(UserModel user) async {
    await userRepo.updateUserData(user);
    userRepo.updateUser(user: user);
  }
}
