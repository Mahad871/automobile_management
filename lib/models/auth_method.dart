import 'package:automobile_management/Screens/home_page.dart';
import 'package:automobile_management/models/device_token.dart';
import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:automobile_management/models/firebase_storage_model.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../databases/user_api.dart';

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

  Future<int> verifyOTP(String verificationId, String otp) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      final UserCredential authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        final UserModel? userModel =
            await UserAPI().user(uid: authCredential.user!.uid);
        if (UserModel == null) return 0; // User is New on App
        return 1; // User Already Exist NO new info needed
      }
      return -1; // ERROR while Entering OTP
    } catch (ex) {
      CustomToast.errorToast(message: ex.toString());
      return -1;
    }
  }

  Future<void> deleteAccount() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserData!.id)
        .delete();
    final QuerySnapshot<Map<String, dynamic>> products = await FirebaseFirestore
        .instance
        .collection('products')
        .where('uid', isEqualTo: currentUserData!.id)
        .get();
    if (products.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in products.docs) {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(doc.data()?['pid'])
            .delete();
      }
      await FirebaseStorage.instance
          .ref('products/${currentUserData?.id}')
          .delete();
    }
    await auth.currentUser!.delete();
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

  Future<void> setDeviceToken(List<MyDeviceToken> deviceToken) async {
    try {
      await db
          .collection('users')
          .doc(currentUserData!.id)
          .update(<String, dynamic>{
        'devices_tokens':
            deviceToken.map((MyDeviceToken e) => e.toMap()).toList()
      });
    } catch (e) {
      CustomToast.errorToast(message: 'Something Went Wrong');
    }
  }

  Future<List<UserModel>> getUserDataWhere() async {
    final snapshot = await db.collection('users').get();
    List<UserModel> currentUserDataList =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).toList();
    return currentUserDataList;
  }

  Future<UserModel> recieveUserData(String id) async {
    final snapshot =
        await db.collection('users').where('uid', isEqualTo: id).get();
    UserModel UserData =
        snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).single;
    // print(currentUserData!.username.toString());
    return UserData;
    notifyListeners();
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

  Stream<UserModel> userDatabyUid(String userId) {
    return db.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  followUser({String followerUid = " ", String followingUid = " "}) async {
    if (followerUid == followingUid) {
      return false;
    }

    try {
      UserModel user = await recieveUserData(followingUid);
      user.followers.add(followerUid);
      currentUserData?.following.add(followingUid);
      user.noOfFollowers = user.followers.length;
      currentUserData!.noOfFollowing = currentUserData!.following.length;
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
      UserModel user = await recieveUserData(followingUid);
      user.followers.remove(followerUid);
      currentUserData?.following.remove(followingUid);
      user.noOfFollowers = user.followers.length;
      currentUserData!.noOfFollowing = currentUserData!.following.length;

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
