import 'package:automobile_management/Screens/chat_screens/personal_chat_page/personal_chat_dashboard.dart';
import 'package:automobile_management/Screens/chat_screens/personal_chat_page/personal_chat_screen.dart';
import 'package:automobile_management/databases/chat_api.dart';
import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:automobile_management/function/time_date_functions.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/chat/chat.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/providers/user/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      userProfileImage: const Icon(
        CupertinoIcons.person_alt,
        color: Colors.black,
        size: 30,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
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
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
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
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        ));
                      }

                      // print(snapshot.data!.docs[index]["persons"]);
                      List<String> participants = [];
                      participants.add(
                          snapshot.data!.docs[index]["persons"][0].toString());
                      participants.add(
                          snapshot.data!.docs[index]["persons"][1].toString());
                      List<UserModel> listUsers = sl
                          .get<UserProvider>()
                          .usersFromListOfString(uidsList: participants);
                      var lastMessageDetails =
                          snapshot.data!.docs[index]["last_message"];

                      // print(lastMessageDetails['text']);

                      Chat currentChat = Chat(
                          isGroup: false,
                          chatID: snapshot.data!.docs[index]["chat_id"],
                          persons: participants);
                      String? userPic = listUsers[0].id !=
                              sl.get<AuthMethod>().currentUserData?.id
                          ? listUsers[0].photoUrl
                          : listUsers[1].photoUrl;
                      return ListTile(
                          title: ChatListCard(
                        userProfileImage: CachedNetworkImage(
                          imageUrl: userPic ?? defualtUserImg,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        time: lastMessageDetails != null
                            ? TimeDateFunctions.timeInDigits(
                                lastMessageDetails['timestamp'])
                            : "",
                        lastMessageText: lastMessageDetails != null
                            ? lastMessageDetails['text']
                            : "",
                        username: listUsers[0].id !=
                                sl.get<AuthMethod>().currentUserData?.id
                            ? listUsers[0].username
                            : listUsers[1].username,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersonalChatScreen(
                                    chat: currentChat,
                                    chatWith: listUsers[0].id !=
                                            sl
                                                .get<AuthMethod>()
                                                .currentUserData
                                                ?.id
                                        ? listUsers[0]
                                        : listUsers[1]),
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
