import 'package:automobile_management/databases/user_api.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get getCurrentUser => _auth.currentUser;
  static String get uid => _auth.currentUser?.uid ?? '';
  static String get phoneNumber => _auth.currentUser?.phoneNumber ?? '';

  Future<int> verifyOTP(String verificationId, String otp) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      final UserCredential authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

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
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    final QuerySnapshot<Map<String, dynamic>> products = await FirebaseFirestore
        .instance
        .collection('products')
        .where('uid', isEqualTo: uid)
        .get();
    if (products.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in products.docs) {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(doc.data()?['pid'])
            .delete();
      }
      await FirebaseStorage.instance.ref('products/$uid').delete();
    }
    await _auth.currentUser!.delete();
  }

  // Future<void> signOut(BuildContext context) async {
  //   final UserModel me = Provider.of<UserProvider>(context, listen: false)
  //       .user(uid: AuthMethods.uid);
  //   final String? token = await NotificationsServices.getToken();
  //   me.deviceToken!.remove(token ?? MyDeviceToken(token: token ?? ''));
  //   await UserAPI().setDeviceToken(me.deviceToken ?? <MyDeviceToken>[]);
  //   await _auth.signOut();
  // }
}
