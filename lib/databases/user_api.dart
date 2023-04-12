import 'dart:io';

import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/device_token.dart';
import 'auth_methods.dart';

class UserAPI {
  static const String _collection = 'users';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  // Future<void> updateProfile({required UserModel user}) async {
  //   if (user.uid != AuthMethods.uid) return;
  //   try {
  //     await _instance
  //         .collection(_collection)
  //         .doc(user.id)
  //         .update(user.updateProfile());
  //   } catch (e) {
  //     CustomToast.errorToast(message: e.toString());
  //   }
  // }

  Future<void> setDeviceToken(List<MyDeviceToken> deviceToken) async {
    try {
      await _instance
          .collection(_collection)
          .doc(AuthMethods.uid)
          .update(<String, dynamic>{
        'devices_tokens':
            deviceToken.map((MyDeviceToken e) => e.toMap()).toList()
      });
    } catch (e) {
      CustomToast.errorToast(message: 'Something Went Wrong');
    }
  }


  // Future<void> unblockTo({required UserModel user}) async {
  //   try {
  //     await _instance
  //         .collection(_collection)
  //         .doc(user.uid)
  //         .update(user.unblockTO());
  //   } catch (e) {
  //     CustomToast.errorToast(message: e.toString());
  //   }
  // }

  // Future<void> unblockBy({required UserModel user}) async {
  //   try {
  //     await _instance
  //         .collection(_collection)
  //         .doc(user.uid)
  //         .update(user.unblockBy());
  //   } catch (e) {
  //     CustomToast.errorToast(message: e.toString());
  //   }
  // }

  // Future<void> blockTo({required UserModel user}) async {
  //   try {
  //     await _instance
  //         .collection(_collection)
  //         .doc(user.uid)
  //         .update(user.blockToUpdate());
  //   } catch (e) {
  //     CustomToast.errorToast(message: e.toString());
  //   }
  // }

  // Future<void> blockBy({required UserModel user}) async {
  //   try {
  //     await _instance
  //         .collection(_collection)
  //         .doc(user.uid)
  //         .update(user.blockByUpdate());
  //   } catch (e) {
  //     CustomToast.errorToast(message: e.toString());
  //   }
  // }

  // Future<void> report({required UserModel user}) async {
  //   try {
  //     await _instance
  //         .collection(_collection)
  //         .doc(user.uid)
  //         .update(user.report());
  //   } catch (e) {
  //     CustomToast.errorToast(message: e.toString());
  //   }
  // }

  Future<bool> register({required UserModel user}) async {
    try {
      await _instance.collection(_collection).doc(user.id).set(user.toJson());
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<UserModel?> user({required String uid}) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).doc(uid).get();
    if (!doc.exists) return null;
    final UserModel userModel = UserModel.fromDocumentSnapshot(doc);
    return userModel;
  }

  Future<List<UserModel>> getAllUsers() async {
    final List<UserModel> userModel = <UserModel>[];
    final QuerySnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).get();

    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      userModel.add(UserModel.fromDocumentSnapshot(element));
    }
    return userModel;
  }

  Future<String?> uploadProfilePhoto({required File file}) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref('profile_photos/${AuthMethods.uid}')
          .putFile(file);
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
