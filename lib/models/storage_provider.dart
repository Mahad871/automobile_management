import 'package:automobile_management/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider extends ChangeNotifier {
  late UserModel userData;
  bool islogged = false;
  GetStorage localStorage = GetStorage();

  void storeUserData(UserModel user) {
    localStorage.write('isLogged', true);
    localStorage.write('user', user);
  }

  void deleteOldData() {
    localStorage.write('isLogged', false);
    localStorage.remove('user');
  }

  UserModel fetchUserData() {
    islogged = localStorage.read('isLogged');
    userData = localStorage.read('user');
    return userData;
  }
}
