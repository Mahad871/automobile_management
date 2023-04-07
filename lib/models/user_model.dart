import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? id;
  late String? photoUrl;
  final String username;
  final String email;
  final String password;
  final List<dynamic> followers;
  final List<dynamic> following;
  final bool isVendor;
  final Uint8List? file;
  late int noOfFollowers;
  late int noOfFollowing;

  UserModel(
      {this.id,
      this.photoUrl,
      required this.username,
      required this.email,
      required this.isVendor,
      required this.password,
      required this.followers,
      required this.following,
      this.noOfFollowers = 0,
      this.noOfFollowing = 0,
      this.file});

  toJson() {
    return {
      "uid": id,
      "username": username,
      "email": email,
      "isVendor": isVendor,
      "password": password,
      // "img": file,
      "photoUrl": photoUrl,
      "followers": followers,
      "following": following,
<<<<<<< HEAD
      "noOfFollowers": noOfFollowers,
      "noOfFollowing": noOfFollowing
=======
>>>>>>> cd1362fb92693422d3c77ed84f28d8890fe650d7
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
      followers: doc.data()!['followers'],
      following: doc.data()!['following'],
<<<<<<< HEAD
      noOfFollowing: doc.data()!['noOfFollowing'],
      noOfFollowers: doc.data()!['noOfFollowers'],
=======
>>>>>>> cd1362fb92693422d3c77ed84f28d8890fe650d7
    );
  }
}
