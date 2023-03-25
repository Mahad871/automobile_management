import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? id;
  late String? photoUrl;
  final String username;
  final String email;
  final String password;
  final bool isVendor;
  final Uint8List? file;

  UserModel(
      {this.id,
      this.photoUrl,
      required this.username,
      required this.email,
      required this.isVendor,
      required this.password,
      this.file});

  toJson() {
    return {
      "uid": id,
      "username": username,
      "email": email,
      "isVendor": isVendor,
      "password": password,
      // "img": file,
      "photoUrl": photoUrl
    };
  }

  factory UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
      id: doc.id,
      password: doc.data()!["password"],
      username: doc.data()!["username"],
      email: doc.data()!["email"],
      isVendor: doc.data()!['isVendor'],
      // file: doc.data()!['imgUrl'],
      photoUrl: doc.data()!['photoUrl'],
    );
  }
}
