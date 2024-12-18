import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:automobile_management/enums/notification_enum.dart';

class MyNotification {
  MyNotification({
    required this.notificationID,
    required this.productID,
    required this.fromUID,
    required this.toUID,
    required this.type,
    required this.title,
    required this.body,
    required this.timestamp,
    this.chatId,
    this.imgUrl,
  });

  final String notificationID;
  final String productID;
  final String fromUID;
  final String toUID;
  final String? chatId;
  final NotificationType type;
  final String title;
  final String body;
  final int timestamp;
  final String? imgUrl;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notification_id': notificationID,
      'product_id': productID,
      'from_uid': fromUID,
      'to_uid': toUID,
      'type': type.json,
      'title': title,
      'body': body,
      'timestamp': timestamp,
      'imgUrl': imgUrl,
      'chatId': chatId,
    };
  }

  // ignore: sort_constructors_first
  factory MyNotification.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return MyNotification(
      notificationID: doc.data()?['notification_id'] ?? '',
      productID: doc.data()?['product_id'] ?? '',
      fromUID: doc.data()?['from_uid'] ?? '',
      toUID: doc.data()?['to_uid'] ?? '',
      type: NotificationTypeConvertor.toEnum(
          doc.data()?['type'] ?? NotificationType.message.json),
      title: doc.data()?['title'] ?? '',
      body: doc.data()?['body'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? 0,
      imgUrl: doc.data()?['imgUrl'] ?? '',
      chatId: doc.data()?['chatId'] ?? '',
    );
  }
}
