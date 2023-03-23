import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? id;
  final String username;
  final String email;
  final String password;
  final bool isVendor;

  UserModel(
      {this.id,
      required this.username,
      required this.email,
      required this.isVendor,
      required this.password});

  toJson() {
    return {
      "uid": id,
      "username": username,
      "email": email,
      "isVendor": isVendor,
      "password": password,
    };
  }

  factory UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
        id: doc.id,
        password: doc.data()!["password"],
        username: doc.data()!["username"],
        email: doc.data()!["email"],
        isVendor: doc.data()!['isVendor']);
  }
}
