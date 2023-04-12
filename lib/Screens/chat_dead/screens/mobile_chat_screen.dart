import 'package:automobile_management/Common/constants.dart';
import 'package:automobile_management/Screens/chat_dead/widgets/bottom_chat_field.dart';
import 'package:automobile_management/Screens/chat_dead/widgets/chat_list.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/providers/auth_controller.dart';
import 'package:automobile_management/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;

  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  }) : super(key: key);

  // void makeCall(WidgetRef ref, BuildContext context) {
  //   ref.read(callControllerProvider).makeCall(
  //         context,
  //         name,
  //         uid,
  //         profilePic,
  //         isGroupChat,
  //       );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
        //  CallPickupScreen(
        //   scaffold:
        Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: isGroupChat
            ? Text(name)
            : StreamBuilder<UserModel>(
                stream: ref.read(authControllerProvider).userDataById(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return Column(
                    children: [
                      Text(name),
                      Text(
                        snapshot.data!.isOnline ? 'online' : 'offline',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }),
        centerTitle: false,
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              recieverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ),
          BottomChatField(
            recieverUserId: uid,
            isGroupChat: isGroupChat,
          ),
        ],
      ),
    );
    // );
  }
}
