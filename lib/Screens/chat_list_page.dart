import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common/constants.dart';
import '../Widgets/notification_card.dart';

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
  List<NotificationCard> notificationsList = [
    NotificationCard(
      userProfileImage: Icon(
        CupertinoIcons.person_alt,
        color: Colors.black,
        size: 30,
      ),
    ),
  ];
  void addNotifications() {
    setState(() {
      notificationsList.add(NotificationCard(
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
              addNotifications();
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListView.builder(
                itemCount: notificationsList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) => notificationsList[index],
              ),
            ),
          ),
        ));

    return scaffold;
  }
}
