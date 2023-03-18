import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common/constants.dart';
import '../Common/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;
  List<NotificationCard> notificationsList = [
    const NotificationCard(
      userProfileImage: Icon(
        CupertinoIcons.person_alt,
        color: Colors.black,
        size: 30,
      ),
    ),
  ];
  void addNotifications() {
    setState(() {
      notificationsList.add(const NotificationCard(
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
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: textFieldColor,
              foregroundColor: textColor,
              shadowColor: Colors.white,
              elevation: 0,
              title: const Text(
                "Notifiactions",
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
