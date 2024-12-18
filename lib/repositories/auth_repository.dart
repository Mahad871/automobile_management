// import 'dart:io';

// import 'package:automobile_management/models/user_model.dart';
// import 'package:automobile_management/repositories/common_firebase_storage_repository.dart';
// import 'package:automobile_management/utilities/utils.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final authRepositoryProvider = Provider(
//   (ref) => AuthRepository(
//     auth: FirebaseAuth.instance,
//     firestore: FirebaseFirestore.instance,
//   ),
// );

// class AuthRepository {
//   final FirebaseAuth auth;
//   final FirebaseFirestore firestore;
//   AuthRepository({
//     required this.auth,
//     required this.firestore,
//   });

//   Future<UserModel?> getCurrentUserData() async {
//     var userData =
//         await firestore.collection('users').doc(auth.currentUser?.uid).get();

//     UserModel? user;
//     if (userData.data() != null) {
//       user = UserModel.fromMap(userData.data()!);
//     }
//     return user;
//   }

//   void registerUser(BuildContext context, String name, String email,
//       String password, ProviderRef ref, File? profilePic) async {
//     try {
//       final credential = await auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       saveUserDataToFirebase(
//           name: name,
//           email: email,
//           profilePic: profilePic,
//           ref: ref,
//           context: context);
//       // Navigator.pushNamedAndRemoveUntil(
//       //   context,
//       //   MobileLayoutScreen.routeName,
//       //   (route) => false,
//       // );
//     } catch (e) {
//       print(e);
//     }
//   }
//   void loginUser(BuildContext context, String name, String email,
//       String password, ProviderRef ref, File? profilePic) async {
//     try {
//       final credential = await auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       saveUserDataToFirebase(
//           name: name,
//           email: email,
//           profilePic: profilePic,
//           ref: ref,
//           context: context);
//       // Navigator.pushNamedAndRemoveUntil(
//       //   context,
//       //   MobileLayoutScreen.routeName,
//       //   (route) => false,
//       // );
//     } catch (e) {
//       print(e);
//     }
//   }


 
//   void saveUserDataToFirebase({
//     required String name,
//     required String email,
//     required File? profilePic,
//     required ProviderRef ref,
//     required BuildContext context,
//   }) async {
//     try {
//       String uid = auth.currentUser!.uid;
//       String photoUrl =
//           'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

//       if (profilePic != null) {
//         photoUrl = await ref
//             .read(commonFirebaseStorageRepositoryProvider)
//             .storeFileToFirebase(
//               'profilePic/$uid',
//               profilePic,
//             );
//       }

//       // var user = UserModel(
//       //   name: name,
//       //   uid: uid,
//       //   email: email,
//       //   profilePic: photoUrl,
//       //   isOnline: true,
//       //   phoneNumber: auth.currentUser!.phoneNumber!,
//       //   groupId: [],
//       // );

//       // await firestore.collection('users').doc(uid).set(user.toMap());

//       // Navigator.pushAndRemoveUntil(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => const MobileLayoutScreen(),
//       //   ),
//       //   (route) => false,
//       // );
//     } catch (e) {
//       showSnackBar(context: context, content: e.toString());
//     }
//   }

//   Stream<UserModel> userData(String userId) {
//     return firestore.collection('users').doc(userId).snapshots().map(
//           (event) => UserModel.fromMap(
//             event.data()!,
//           ),
//         );
//   }

//   void setUserState(bool isOnline) async {
//     await firestore.collection('users').doc(auth.currentUser!.uid).update({
//       'isOnline': isOnline,
//     });
//   }
// }
