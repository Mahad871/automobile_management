import 'dart:io';

import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/chat/chat.dart';
import '../models/chat/message.dart';
import '../models/device_token.dart';
// import 'auth_methods.dart';
import 'notification_service.dart';

class ChatAPI {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'chat';
  static const String _subCollection = 'messages';
  static final AuthMethod authMethod = sl.get<AuthMethod>();
  List<Chat> chatsList = <Chat>[];
  Stream<List<Message>> messages(String chatID) {
    return _instance
        .collection(_collection)
        .doc(chatID)
        .collection(_subCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> event) {
      final List<Message> messages = <Message>[];
      for (DocumentSnapshot<Map<String, dynamic>> element in event.docs) {
        final Message temp = Message.fromMap(element.data()!);
        messages.add(temp);
      }
      return messages;
    });
  }

  Future<List<Chat>> getchats() async {

  QuerySnapshot<Map<String, dynamic>> querySnapshot = await _instance
      .collection(_collection)
      .where('persons', arrayContains: authMethod.currentUserData?.id)
      .where('is_group', isEqualTo: false)
      .orderBy('timestamp', descending: true)
      .get();

  for (DocumentSnapshot<Map<String, dynamic>> element in querySnapshot.docs) {
    final Chat temp = Chat.fromMap(element.data()!);
    chatsList.add(temp);
  }

  print("recent chats: $chatsList");

  return chatsList;
}


  Stream<List<Chat>> chats() {
    // Firebase Index need to add
    // Composite Index
    // Collection ID -> chat
    // Field Indexed -> persons Arrays is_group Ascending timestamp Descending
    chatsList.clear();
    return _instance
        .collection(_collection)
        .where('persons', arrayContains: authMethod.currentUserData?.id)
        .where('is_group', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .asyncMap((QuerySnapshot<Map<String, dynamic>> event) {
      for (DocumentSnapshot<Map<String, dynamic>> element in event.docs) {
        final Chat temp = Chat.fromMap(element.data()!);
        chatsList.add(temp);
      }
      return chatsList;
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats() {
    // Firebase Index need to add
    // Composite Index
    // Collection ID -> chat
    // Field Indexed -> persons Arrays is_group Ascending timestamp Descending
    return _instance
        .collection(_collection)
        .where("persons", arrayContains: authMethod.currentUserData?.id)
        .snapshots();
  }

  Stream<List<Chat>> groups() {
    // Firebase Index need to add
    // Composite Index
    // Collection ID -> chat
    // Field Indexed -> persons Arrays is_group Descending timestamp Descending
    return _instance
        .collection(_collection)
        .where('persons', arrayContains: authMethod.currentUserData!.id)
        .where('is_group', isEqualTo: true)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .asyncMap((QuerySnapshot<Map<String, dynamic>> event) {
      List<Chat> chats = <Chat>[];
      for (DocumentSnapshot<Map<String, dynamic>> element in event.docs) {
        final Chat temp = Chat.fromMap(element.data()!);
        chats.add(temp);
      }
      return chats;
    });
  }

  Future<void> sendMessage({
    required Chat chat,
    required UserModel receiver,
    required UserModel sender,
  }) async {
    final Message? newMessage = chat.lastMessage;
    try {
      if (newMessage != null) {
        await _instance
            .collection(_collection)
            .doc(chat.chatID)
            .collection(_subCollection)
            .doc(newMessage.messageID)
            .set(newMessage.toMap());
      }
      await _instance
          .collection(_collection)
          .doc(chat.chatID)
          .set(chat.toMap());
      if (receiver.deviceToken?.isNotEmpty ?? false) {
        await NotificationsServices().sendSubsceibtionNotification(
          deviceToken: receiver.deviceToken ?? <MyDeviceToken>[],
          messageTitle: sender.username ?? 'App User',
          messageBody: newMessage!.text ?? 'Send you a message',
          data: <String>['chat', 'message', 'personal'],
        );
      }
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<void> addMembers(Chat chat) async {
    final Message? newMessage = chat.lastMessage;
    try {
      if (newMessage != null) {
        await _instance
            .collection(_collection)
            .doc(chat.chatID)
            .update(chat.addMembers());
        await _instance
            .collection(_collection)
            .doc(chat.chatID)
            .collection(_subCollection)
            .doc(newMessage.messageID)
            .set(newMessage.toMap());
      }
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  chatExists(List<String> persons) async {
    bool chatExists = false;
    var chatsList = await chats();

    StreamBuilder(
        builder: (context, snapshot) {
          print(snapshot.data?.asMap());
          if (snapshot.hasData) {
            chatExists = true;
          }
          return Text('data');
        },
        stream: chatsList);

    return chatExists;
  }

  Future createChat(String chatID, List<String> persons) async {
    var chatExist = await chatExists(persons);
    if (!chatExist) {
      print("chat does not exist");
      Chat chat = Chat(chatID: chatID, persons: persons);
      _instance
          .collection(_collection)
          .doc(chatID)
          .set(chat.toJson())
          .whenComplete(() => chat);

      return chat;
    }
    print("chat exists");

    return Chat(chatID: '-1', persons: persons);
  }

  Future<String?> uploadAttachment({
    required File file,
    required String attachmentID,
  }) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref('chat/personal/${authMethod.currentUserData?.id}/$attachmentID}')
          .putFile(file);
      String url = (await snapshot.ref.getDownloadURL()).toString();
      return url;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return null;
    }
  }

  Future<String?> uploadGroupImage({
    required File file,
    required String attachmentID,
  }) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref('chat/group/${authMethod.currentUserData?.id}/$attachmentID}')
          .putFile(file);
      String url = (await snapshot.ref.getDownloadURL()).toString();
      return url;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return null;
    }
  }

  static List<String> othersUID(List<String> usersValue) {
    List<String> myUsers = usersValue
        .where((String element) => element != authMethod.auth.currentUser!.uid)
        .toList();
    return myUsers.isEmpty ? <String>[''] : myUsers;
  }
}
