import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/my_notification.dart';
import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/notification_enum.dart';
import 'auth_methods.dart';

class NotificationAPI {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'notifications';

  sendNotification(MyNotification value) async {
    if (value.toUID == AuthMethods.uid) return;
    await _instance
        .collection(_collection)
        .doc(value.notificationID)
        .set(value.toMap());
  }

  Future<List<MyNotification>> notificationsOfType(
      NotificationType type) async {
    final List<MyNotification> notice = <MyNotification>[];
    try {
      final QuerySnapshot<Map<String, dynamic>> docs = await _instance
          .collection(_collection)
          .where('to_uid',
              isEqualTo: sl.get<AuthMethod>().currentUser!.user!.uid)
          .where('type', isEqualTo: type.json)
          .orderBy('timestamp')
          .get();
      if (docs.docs.isEmpty) notice;
      for (DocumentSnapshot<Map<String, dynamic>> element in docs.docs) {
        notice.add(MyNotification.fromDoc(element));
      }
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
    return notice;
  }

  Future<List<MyNotification>> getAllNotifications() async {
    final List<MyNotification> notice = <MyNotification>[];
    try {
      final QuerySnapshot<Map<String, dynamic>> docs = await _instance
          .collection(_collection)
          .where('to_uid',
              isEqualTo: sl.get<AuthMethod>().currentUser!.user!.uid)
          .orderBy('timestamp')
          .get();
      if (docs.docs.isEmpty) notice;
      for (DocumentSnapshot<Map<String, dynamic>> element in docs.docs) {
        notice.add(MyNotification.fromDoc(element));
      }
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
    return notice;
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getAllNotificationsFuture() async {
    return await _instance.collection(_collection).orderBy('timestamp').get();
  }
}
