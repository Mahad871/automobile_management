// import 'dart:io';
// import 'package:automobile_management/models/user_model.dart';
// import 'package:automobile_management/repositories/auth_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';


// final authControllerProvider = Provider((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AuthController(authRepository: authRepository, ref: ref);
// });

// final userDataAuthProvider = FutureProvider((ref) {
//   final authController = ref.watch(authControllerProvider);
//   return authController.getUserData();
// });

// class AuthController {
//   final AuthRepository authRepository;
//   final ProviderRef ref;
//   AuthController({
//     required this.authRepository,
//     required this.ref,
//   });

//   Future<UserModel?> getUserData() async {
//     UserModel? user = await authRepository.getCurrentUserData();
//     return user;
//   }



//   void registeruser(BuildContext context, String name, String email,
//       String password, File? profilePic) {
//     authRepository.registerUser(
//         context, name, email, password, ref, profilePic);
//   }


//   void saveUserDataToFirebase(
//       {required BuildContext context,
//       required String name,
//       required String email,
//       required String password,
//       File? profilePic}) {
//     authRepository.saveUserDataToFirebase(
//       name: name,
//       email: email,
//       profilePic: profilePic,
//       ref: ref,
//       context: context,
//     );
//   }

//   Stream<UserModel> userDataById(String userId) {
//     return authRepository.userData(userId);
//   }

//   void setUserState(bool isOnline) {
//     authRepository.setUserState(isOnline);
//   }
// }
