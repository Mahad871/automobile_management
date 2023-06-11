import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? userId;
  final String? notificationId;
  final String? notificationTitle;
  final String? description;
  final Timestamp? timestamp;
  final String? token;
  final String? imageUrl;

  NotificationModel({
    this.userId,
    this.notificationId,
    this.notificationTitle,
    this.description,
    this.timestamp,
    this.token,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {};
  }

  factory NotificationModel.fromDocument(doc) {
    return NotificationModel(
      userId: doc.data()["userId"],
      notificationId: doc.data()["notificationId"],
      notificationTitle: doc.data()["notificationTitle"],
      description: doc.data()["description"],
      timestamp: doc.data()["timestamp"],
      token: doc.data()["token"],
      imageUrl: doc.data()["imageUrl"],
    );
  }
}
