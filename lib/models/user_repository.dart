import 'package:automobile_management/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  createUser(UserModel user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      await _db.collection('users').add(user.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> siginUser(
      {required String email, required String password}) async {
    final _user = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .whenComplete(
      () {
        print("SignIn Completed SuccessFully !");
      },
    );
    if (_auth.currentUser != null) {
      var userData = await getCurrentUserData(_auth.currentUser?.email);
      return userData;
    }
    return UserModel(
        username: "none", email: "none", isVendor: false, password: "123");
  }

  updateUser({required UserModel user}) async {
    final _user = await _auth
        .signInWithEmailAndPassword(
            email: user.email.trim(), password: user.password.trim())
        .whenComplete(
      () {
        print("SignIn Completed SuccessFully !");
      },
    );

    if (_user.user != null) {
      _user.user!.updateEmail(user.email);
      _user.user!.updatePassword(user.password);
      _user.user!.updateDisplayName(user.username);
    }
  }

  updateUserData(UserModel user) async {
    await _db.collection('users').doc(user.id).update(user.toJson());
  }

  Future<UserModel> getCurrentUserData(String? mail) async {
    final snapshot =
        await _db.collection('users').where('email', isEqualTo: mail).get();
    var currentUserData =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).single;
    return currentUserData;
  }

  Future<List<UserModel>> getAllUserData() async {
    final snapshot = await _db.collection('users').get();
    var currentUserData =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).toList();
    return currentUserData;
  }
}
