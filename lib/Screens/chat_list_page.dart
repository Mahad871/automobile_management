import 'package:automobile_management/Screens/chat_screens/personal_chat_page/personal_chat_dashboard.dart';
import 'package:automobile_management/Screens/chat_screens/personal_chat_page/personal_chat_screen.dart';
import 'package:automobile_management/databases/chat_api.dart';
import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:automobile_management/models/chat/chat.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/providers/user/user_provider.dart';
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
                  // List<Chat> chatsList = [];
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

                      print(snapshot.data!.docs[index]["persons"]);
                      List<String> participants = [];
                      participants.add(
                          snapshot.data!.docs[index]["persons"][0].toString());
                      participants.add(
                          snapshot.data!.docs[index]["persons"][1].toString());
                      List<UserModel> listUsers = sl
                          .get<UserProvider>()
                          .usersFromListOfString(uidsList: participants);
                      Chat currentChat = Chat(
                          // lastMessage: snapshot.data!.docs[index]
                          //     ["last_message"],
                          chatID: snapshot.data!.docs[index]["chat_id"],
                          persons: participants);
                      participants.clear();
                      return ListTile(
                          title: ChatListCard(
                        username: listUsers[0].username,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersonalChatScreen(
                                    chat: currentChat, chatWith: listUsers[0]),
                              ));
                        },
                      ));
                    },
                  );
                }),
          ),
        ));

    return scaffold;
  }
}
