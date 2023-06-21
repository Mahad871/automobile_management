import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:automobile_management/Common/constants.dart';
import 'package:automobile_management/databases/user_api.dart';
import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:automobile_management/function/time_date_function.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/utilities/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../models/device_token.dart';
import 'auth_methods.dart';

class NotificationsServices {
  static AuthMethod authMethod = sl.get<AuthMethod>();
  // static late String? deviceToken;
  static final FlutterLocalNotificationsPlugin localNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String?> onNotification =
      BehaviorSubject<String?>();
  static Future<void> init() async {
    log('NOTIFICATION INIT START');
    await Permission.notification.request();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            defaultPresentSound: true,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await localNotificationPlugin.initialize(initializationSettings);
    await FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        onNotification.add(details.payload);
        if (kDebugMode) {
          debugPrint('notification payload :${details.payload!} ');
          debugPrint('notification payload :${details.id} ');
          debugPrint('notification payload :${details.payload} ');
        }
      },
    );
    await localNotificationPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        debugPrint('Message data: ${message.data}');
      }
      if (message.notification != null) {
        // _notificationDetails();
        bool validURL = Uri.parse(message.notification!.body!).isAbsolute;

        if (validURL) {
          String? imgPath = await _downloadAndSavePicture(
              message.notification!.body!, TimeStamp.timestamp.toString());
          _notificationDetails(message.notification!.title!,
              message.notification!.body!, imgPath!, true);
          print("IMAGE PATH CHECK: $imgPath");
          // await authMethod.addNotifications(
          //     postId: const Uuid().v4(),
          //     announcementTitle: message.notification!.title!,
          //     imageUrl: message.notification!.body!,
          //     eachUserId: authMethod.currentUser?.user?.uid ?? 'noti_idmissing',
          //     eachUserToken:
          //         authMethod.currentUserData?.deviceToken?.first.token ??
          //             'notiTokenMissing',
          //     description: 'Do you have This Product');
          showNotification(
              title: message.notification!.title!,
              body: imgPath,
              payload:
                  '${message.data['key1']}-${message.data['key2']}-${message.data['key3']}',
              isImage: true);
        } else {
          // await authMethod.addNotifications(
          //     postId: const Uuid().v4(),
          //     announcementTitle: message.notification!.title!,
          //     imageUrl: defualtUserImg,
          //     eachUserId: authMethod.currentUser?.user?.uid ?? 'noti_idmissing',
          //     eachUserToken:
          //         authMethod.currentUserData?.deviceToken?.first.token ??
          //             'notiTokenMissing',
          //     description: message.notification!.body!);
          _notificationDetails(message.notification!.title!,
              message.notification!.body!, '', false);
          print("IMAGE PATH CHECK: ${message.notification!.body!}");
          showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload:
                '${message.data['key1']}-${message.data['key2']}-${message.data['key3']}',
          );
        }
      }
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      if (kDebugMode) {
        debugPrint('Message data: ${message.data}');
      }
      if (message.notification != null) {
        // _notificationDetails();
        bool validURL = Uri.parse(message.notification!.body!).isAbsolute;

        if (validURL) {
          String? imgPath = await _downloadAndSavePicture(
              message.notification!.body!, TimeStamp.timestamp.toString());
          _notificationDetails(message.notification!.title!,
              message.notification!.body!, imgPath!, true);
          print("IMAGE PATH CHECK: $imgPath");
          // await authMethod.addNotifications(
          //     postId: const Uuid().v4(),
          //     announcementTitle: message.notification!.title!,
          //     imageUrl: message.notification!.body!,
          //     eachUserId: authMethod.currentUser?.user?.uid ?? 'noti_idmissing',
          //     eachUserToken:
          //         authMethod.currentUserData?.deviceToken?.first.token ??
          //             'notiTokenMissing',
          //     description: 'Do you have This Product');
          showNotification(
              title: message.notification!.title!,
              body: imgPath,
              payload:
                  '${message.data['key1']}-${message.data['key2']}-${message.data['key3']}',
              isImage: true);
        } else {
          // await authMethod.addNotifications(
          //     postId: const Uuid().v4(),
          //     announcementTitle: message.notification!.title!,
          //     imageUrl: defualtUserImg,
          //     eachUserId: authMethod.currentUser?.user?.uid ?? 'noti_idmissing',
          //     eachUserToken:
          //         authMethod.currentUserData?.deviceToken?.first.token ??
          //             'notiTokenMissing',
          //     description: message.notification!.body!);
          _notificationDetails(message.notification!.title!,
              message.notification!.body!, '', false);
          print("IMAGE PATH CHECK: ${message.notification!.body!}");
          showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload:
                '${message.data['key1']}-${message.data['key2']}-${message.data['key3']}',
          );
        }
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (kDebugMode) {
        debugPrint('Message data: ${message.data}');
      }
      if (message.notification != null) {
        // _notificationDetails();
        bool validURL = Uri.parse(message.notification!.body!).isAbsolute;

        if (validURL) {
          String? imgPath = await _downloadAndSavePicture(
              message.notification!.body!, TimeStamp.timestamp.toString());
          _notificationDetails(message.notification!.title!,
              message.notification!.body!, imgPath!, true);
          print("IMAGE PATH CHECK: $imgPath");
          // await authMethod.addNotifications(
          //     postId: const Uuid().v4(),
          //     announcementTitle: message.notification!.title!,
          //     imageUrl: message.notification!.body!,
          //     eachUserId: authMethod.currentUser?.user?.uid ?? 'noti_idmissing',
          //     eachUserToken:
          //         authMethod.currentUserData?.deviceToken?.first.token ??
          //             'notiTokenMissing',
          //     description: 'Do you have This Product');
          showNotification(
              title: message.notification!.title!,
              body: imgPath,
              payload:
                  '${message.data['key1']}-${message.data['key2']}-${message.data['key3']}',
              isImage: true);
        } else {
          // await authMethod.addNotifications(
          //     postId: const Uuid().v4(),
          //     announcementTitle: message.notification!.title!,
          //     imageUrl: defualtUserImg,
          //     eachUserId: authMethod.currentUser?.user?.uid ?? 'noti_idmissing',
          //     eachUserToken:
          //         authMethod.currentUserData?.deviceToken?.first.token ??
          //             'notiTokenMissing',
          //     description: message.notification!.body!);
          _notificationDetails(message.notification!.title!,
              message.notification!.body!, '', false);
          print("IMAGE PATH CHECK: ${message.notification!.body!}");
          showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload:
                '${message.data['key1']}-${message.data['key2']}-${message.data['key3']}',
          );
        }
      }
    });
    await getToken();
    log('NOTIFICATION INIT DONE');
  }

  static Future<String?> _downloadAndSavePicture(
      String? url, String fileName) async {
    if (url == null) return null;
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<bool> sendSubsceibtionNotification({
    required List<MyDeviceToken> deviceToken,
    required String messageTitle,
    required String messageBody,
    required List<String> data,
  }) async {
    // String value3 = data.length == 2 ? '' : data[2];
    // HttpsCallable func =
    //     FirebaseFunctions.instance.httpsCallable('notifySubscribers');
    // // ignore: always_specify_types
    // final HttpsCallableResult res = await func.call(
    //   <String, dynamic>{
    //     'targetDevices': deviceToken,
    //     'messageTitle': messageTitle,
    //     'messageBody': messageBody,
    //     'value1': data[0],
    //     'value2': data[1],
    //     'value3': value3,
    //   },
    // );
    // if (res.data as bool) {
    //   return true;
    try {
      for (int i = 0; i < deviceToken.length; i++) {
        log('Receiver Devive Token: ${deviceToken[i].token}');
        final Map<String, String> headers = <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${Utilities.firebaseServerID}',
        };
        final http.Request request = http.Request(
          'POST',
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
        );
        request.body = json.encode(<String, dynamic>{
          'to': deviceToken[i].token,
          'priority': 'high',
          'notification': <String, String>{
            'body': messageBody,
            'title': messageTitle,
          }
        });
        request.headers.addAll(headers);
        final http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          if (kDebugMode) {
            debugPrint(await response.stream.bytesToString());
          }
          log('Notification send to: ${deviceToken[i].token}');
        } else {
          log('ERROR in FCM');
        }
      }
      return true;
    } catch (e) {
      log('ERROR in FCM: ${e.toString()}');
      return false;
    }
  }

  static Future<String?> getToken() async {
    FirebaseMessaging firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    final String? dToken =
        await firebaseMessaging.getToken().then((String? token) {
      if (kDebugMode) {
        debugPrint('token is $token');
      }

      return token;
    });
    return dToken;
  }

  static NotificationDetails _notificationDetails(
      String title, String body, String imgpath, bool hasPicture) {
    if (hasPicture) {
      return NotificationDetails(
        android: AndroidNotificationDetails('channel Id', 'channel Name',
            channelDescription: 'channel description',
            playSound: true,
            styleInformation: buildBigPictureStyleInformation(
                title, body, imgpath, hasPicture),
            importance: Importance.max),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          presentBadge: true,
          // attachments:  [if (imgpath != null) IOSNotificationAttachment(imgpath)],
        ),
      );
    }

    return const NotificationDetails(
      android: AndroidNotificationDetails('channel Id', 'channel Name',
          channelDescription: 'channel description',
          playSound: true,
          importance: Importance.max),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
      ),
    );
  }

  static BigPictureStyleInformation? buildBigPictureStyleInformation(
    String title,
    String body,
    String? picturePath,
    bool showBigPicture,
  ) {
    if (picturePath == null) return null;
    final FilePathAndroidBitmap filePath = FilePathAndroidBitmap(picturePath);
    return BigPictureStyleInformation(
      showBigPicture ? filePath : const FilePathAndroidBitmap("empty"),
      largeIcon: filePath,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
  }

  static showNotification(
      {required String title,
      required String body,
      required String payload,
      int id = 0,
      bool isImage = false}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    bool isPath = body.contains(directory.path);
    bool isvalidUrl = Uri.parse(body).isAbsolute;
    print("NOTIFICATION PATH: $body");
    print(" PATH: $isPath");
    if (isImage) {
      String? imgPath = Uri.parse(body).isAbsolute
          ? await _downloadAndSavePicture(body, Uuid().v4())
          : body;
      await localNotificationPlugin.show(
        id,
        title,
        "Do You have this Product?",
        _notificationDetails(
            title, "Do You have this Product?", imgPath!, true),
        payload: payload,
      );
    } else {
      await localNotificationPlugin.show(
          id, title, body, _notificationDetails(title, body, payload, false),
          payload: payload);
    }
  }

  static Future<void> cancelNotification(int id) async {
    await localNotificationPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await localNotificationPlugin.cancelAll();
  }

  Future<void> verifyTokenIsUnique({
    required List<UserModel> allUsersValue,
    required String deviceTokenValue,
  }) async {
    final String meUID = AuthMethods.uid;
    for (UserModel element in allUsersValue) {
      if (tokenAlreadyExist(
              devicesValue: (element.deviceToken ?? <MyDeviceToken>[]),
              tokenValue: deviceTokenValue) &&
          element.id != meUID) {
        element.deviceToken?.removeWhere(
            (MyDeviceToken element) => element.token == deviceTokenValue);
        await UserAPI()
            .setDeviceToken(element.deviceToken ?? <MyDeviceToken>[]);
      }
    }
  }

  bool tokenAlreadyExist({
    required List<MyDeviceToken> devicesValue,
    required String tokenValue,
  }) {
    for (MyDeviceToken element in devicesValue) {
      if (element.token == tokenValue) return true;
    }
    return false;
  }
}
