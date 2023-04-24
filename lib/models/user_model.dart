import 'dart:typed_data';
import 'package:automobile_management/models/device_token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? id;
  late String? photoUrl;
  final String username;
  final String email;
  final String password;
  late List<MyDeviceToken>? deviceToken;
  final List<dynamic> followers;
  final List<dynamic> following;
  final bool isVendor;
  final bool isOnline;
  final Uint8List? file;
  late int noOfFollowers;
  late int noOfFollowing;
   double longitude;
   double latitude;

  UserModel(
      {this.id,
      this.photoUrl,
      required this.username,
      required this.email,
      required this.isVendor,
      this.isOnline = true,
      required this.password,
      required this.followers,
      required this.following,
      required this.deviceToken,
      required this.longitude,
      required this.latitude,
      this.noOfFollowers = 0,
      this.noOfFollowing = 0,
      this.file});

  toJson() {
    List<Map<String, dynamic>> tokenList = [];
    deviceToken?.forEach(
      (element) {
        tokenList.add(element.toMap());
      },
    );
    return {
      "uid": id,
      "username": username,
      "email": email,
      "isVendor": isVendor,
      "isOnline": isOnline,
      "password": password,
      // "img": file,
      "photoUrl": photoUrl,
      "followers": followers,
      "following": following,
      "devices_tokens": tokenList,
      "noOfFollowers": noOfFollowers,
      "noOfFollowing": noOfFollowing,
      "longitude": longitude,
      "latitude": latitude
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    List<MyDeviceToken> dtData = <MyDeviceToken>[];
    if (map['devices_tokens'] != null) {
      map['devices_tokens'].forEach((dynamic e) {
        dtData.add(MyDeviceToken.fromMap(e));
      });
    }
    return UserModel(
      id: map['uid'] ?? '',
      password: map['password'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      deviceToken: dtData,
      isVendor: map['isVendor'] ?? false,
      isOnline: map['isOnline'] ?? true,
      // file: map['img'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      followers: map['followers'] ?? [],
      following: map['following'] ?? [],
      noOfFollowing: map['noOfFollowing'] ?? 0,
      noOfFollowers: map['noOfFollowers'] ?? 0,
      longitude: map['longitude'] ?? 0,
      latitude: map['latitude'] ?? 0,
    );
  }

  factory UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    List<MyDeviceToken> dtData = <MyDeviceToken>[];

    if (doc.data()!['devices_tokens'] != null) {
      doc.data()!['devices_tokens'].forEach((dynamic e) {
        dtData.add(MyDeviceToken.fromMap(e));
        print(e);
      });
    }
    return UserModel(
      id: doc.id,
      password: doc.data()!["password"],
      username: doc.data()!["username"],
      email: doc.data()!["email"],
      isVendor: doc.data()!['isVendor'],
      isOnline: doc.data()!['isOnline'],
      deviceToken: dtData,
      // file: doc.data()!['imgUrl'],
      photoUrl: doc.data()!['photoUrl'],
      followers: doc.data()!['followers'],
      following: doc.data()!['following'],
      noOfFollowing: doc.data()!['noOfFollowing'],
      noOfFollowers: doc.data()!['noOfFollowers'],
      longitude: doc.data()?['longitude'],
      latitude: doc.data()?['latitude'],
    );
  }
}
