import 'package:automobile_management/databases/chat_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common/constants.dart';
import '../Widgets/custom_chat_list_card.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;
  List<ChatListCard> chatsList = [
    ChatListCard(
      userProfileImage: Icon(
        CupertinoIcons.person_alt,
        color: Colors.black,
        size: 30,
      ),
    ),
  ];
  void addChat() {
    setState(() {
      chatsList.add(ChatListCard(
        userProfileImage: Icon(
          CupertinoIcons.person_alt,
          color: Colors.black,
          size: 30,
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.notification_add_outlined,
              color: textColor,
            ),
            onPressed: () {
              addChat();
            }),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: textFieldColor,
              foregroundColor: textColor,
              shadowColor: Colors.white,
              elevation: 0,
              title: const Text(
                "Chats",
                style: TextStyle(color: textColor),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: ChatAPI().getAllChats(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading');
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading');
                      }
                      return ListTile(title: ChatListCard());
                    },
                  );
                }),
          ),
        ));

    return scaffold;
  }
}
