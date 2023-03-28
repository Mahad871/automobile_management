import 'package:automobile_management/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider extends ChangeNotifier {
  late UserModel userData;
  GetStorage localStorage = GetStorage();

  void storeUserData(UserModel user) {
    localStorage.write('user', user);
  }

  void deleteOldData() {
    localStorage.write('isLogged', false);
    localStorage.remove('user');
  }

  UserModel fetchUserData() {
    // userData = localStorage.read('user');
    // print(localStorage.read('user').toString());

    return userData;
  }
}
