import 'package:automobile_management/models/storage_model.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/services/databse_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethod extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late UserCredential currentUser;
  late UserModel currentUserData;
  Future<bool> createUser(UserModel user) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      user.id = credential.user!.uid;
      await _db
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toJson());
    } catch (e) {
      print(e);
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<String> siginUser(
      {required String email, required String password}) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      currentUser = cred;
    } catch (e) {
      print(e);
      return e.toString();
    }

    notifyListeners();

    return "success";
  }

  updateUser() async {
    // await _auth
    //     .signInWithEmailAndPassword(
    //         email: currentUser.user!.email.toString(),
    //         password: currentUserData.password)
    //     .then((value) {
    //   currentUser.user!.updateEmail(currentUserData.email);
    //   currentUser.user!.updatePassword(currentUserData.password);
    // });

    String photoUrl = await StorageModel()
        .uploadImageToFIrebase("profilePics", currentUserData.file!, false);

    currentUserData.photoUrl = photoUrl;

    await _db
        .collection('users')
        .doc(currentUser.user!.uid)
        .set(currentUserData.toJson());
    notifyListeners();
  }

  getCurrentUserData(String mail) async {
    final snapshot =
        await _db.collection('users').where('email', isEqualTo: mail).get();
    currentUserData =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).single;
    print(currentUserData.username.toString());
    notifyListeners();
  }

  Future<List<UserModel>> getAllUserData() async {
    final snapshot = await _db.collection('users').get();
    List<UserModel> currentUserDataList =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).toList();
    return currentUserDataList;
  }
}
