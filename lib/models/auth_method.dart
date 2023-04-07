import 'package:automobile_management/Screens/home_page.dart';
import 'package:automobile_management/Widgets/custom_toast.dart';
import 'package:automobile_management/models/firebase_storage_model.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthMethod extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final _storage = GetStorage();

  UserCredential? currentUser;
  UserModel? currentUserData;

  Future<bool> createUser(UserModel user) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      user.id = credential.user!.uid;
      await db.collection('users').doc(credential.user!.uid).set(user.toJson());
    } catch (e) {
      print(e);
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<String> signinUser(
      {required String email, required String password}) async {
    try {
      UserCredential cred = await auth.signInWithEmailAndPassword(
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

    String photoUrl = await FirebaseStorageModel()
        .uploadImageToFIrebase("profilePics", currentUserData!.file!, false);

    currentUserData!.photoUrl = photoUrl;

    await db
        .collection('users')
        .doc(currentUser!.user!.uid)
        .set(currentUserData!.toJson());
    notifyListeners();
  }

  void writeUserdataOnStorage() {
    _storage.write('user', currentUserData);
  }

  getCurrentUserData(String mail) async {
    final snapshot =
        await db.collection('users').where('email', isEqualTo: mail).get();
    currentUserData =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).single;
    // print(currentUserData!.username.toString());
    notifyListeners();
  }

  autoSignIn(String mail) async {
    await getCurrentUserData(mail);
    await signinUser(
        email: currentUserData!.email, password: currentUserData!.password);
    return const HomeScreen();
  }

  Future<List<UserModel>> getAllUserData() async {
    final snapshot = await db.collection('users').get();
    List<UserModel> currentUserDataList =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).toList();
    return currentUserDataList;
  }

  Future<List<UserModel>> getUserDataWhere() async {
    final snapshot = await db.collection('users').get();
    List<UserModel> currentUserDataList =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).toList();
    return currentUserDataList;
  }

  Future<UserModel> getUserData(String id) async {
    final snapshot =
        await db.collection('users').where('uid', isEqualTo: id).get();
    UserModel UserData =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).single;
    // print(currentUserData!.username.toString());
    return UserData;
    notifyListeners();
  }

  Future<String> getUserProfileImage(String uid) async {
    final snapshot =
        await db.collection('users').where('uid', isEqualTo: uid).get();
    UserModel UserData =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).single;
    return UserData.photoUrl.toString();
  }

  followUser({String followerUid = " ", String followingUid = " "}) async {
    if (followerUid == followingUid) {
      return false;
    }

    try {
      UserModel user = await getUserData(followingUid);
      user.followers.add(followerUid);
      currentUserData?.following.add(followingUid);

      await db
          .collection('users')
          .doc(currentUserData!.id)
          .set(currentUserData!.toJson());

      await db.collection('users').doc(user.id).set(user.toJson());
      notifyListeners();
      return true;
    } catch (e) {
      return CustomToast.errorToast(message: e.toString());
    }
  }

  unfollowUser({String followerUid = " ", String followingUid = " "}) async {
    try {
      UserModel user = await getUserData(followingUid);
      user.followers.remove(followerUid);
      currentUserData?.following.remove(followingUid);

      await db
          .collection('users')
          .doc(currentUserData!.id)
          .set(currentUserData!.toJson());

      await db.collection('users').doc(user.id).set(user.toJson());
      notifyListeners();
      return true;
    } catch (e) {
      return CustomToast.errorToast(message: e.toString());
    }
  }

  void signOutUser() async {
    _storage.remove('user');
    await auth.signOut();
    notifyListeners();
  }
}
