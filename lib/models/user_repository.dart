import 'package:automobile_management/Common/constants.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection('users')
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "User Created Successfully!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: textFieldColor,
              colorText: textColor),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Eroor", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textFieldColor,
          colorText: textColor);
      print(error);
    });
  }
}
