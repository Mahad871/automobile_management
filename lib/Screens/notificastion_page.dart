import 'package:automobile_management/Screens/chat_list_page.dart';
import 'package:automobile_management/Screens/chat_screens/personal_chat_page/personal_chat_screen.dart';
import 'package:automobile_management/databases/chat_api.dart';
import 'package:automobile_management/databases/notification_api.dart';
import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:automobile_management/function/time_date_functions.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/chat/chat.dart';
import 'package:automobile_management/models/my_notification.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/providers/user/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common/constants.dart';
import '../widgets/notification_card.dart';

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
    NotificationCard(
      userProfileImage: const Icon(
        CupertinoIcons.person_alt,
        color: Colors.black,
        size: 30,
      ),
    ),
  ];
  void addNotifications() {
    setState(() {
      notificationsList.add(NotificationCard(
        userProfileImage: const Icon(
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
                "Notifications",
                style: TextStyle(color: textColor),
              ),
            ),
            body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: NotificationAPI().getAllNotificationsFuture(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                  List<MyNotification> notiList = [];

                  for (var element in snapshot.data!.docs) {
                    MyNotification notification =
                        MyNotification.fromDoc(element);
                    if (notification.toUID ==
                        sl.get<AuthMethod>().currentUserData!.id) {
                      notiList.add(notification);
                    }
                  }
                  List<UserModel> userList = [];
                  if (notiList.isNotEmpty) {
                    for (var e in notiList) {
                      userList
                          .add(sl.get<UserProvider>().userFromUid(e.fromUID));
                    }
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: notiList.length,
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

                      return ListTile(
                        title: NotificationCard(
                          onPressed: () async {
                            print('asd: ${notiList[index].chatId.runtimeType}');
                            if (notiList[index].chatId != null &&
                                notiList[index].chatId != '') {
                            } else {
                              createChat(notiList[index], context);
                            }
                          },
                          title: notiList[index].title,
                          body: notiList[index].body,
                          time: TimeDateFunctions.timeInDigits(
                              notiList[index].timestamp),
                          showBanner: notiList[index].type.json == 'search'
                              ? true
                              : false,
                          userProfileImage: CachedNetworkImage(
                            imageUrl:
                                userList[index].photoUrl ?? defualtUserImg,
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
                          bannerImage: CachedNetworkImage(
                              imageUrl:
                                  notiList[index].imgUrl ?? defualtUserImg),
                        ),
                      );
                    },
                  );
                }),
          ),
        ));

    return scaffold;
  }

  Future<void> createChat(
      MyNotification notificationData, BuildContext context) async {
    String uploaderID = notificationData.fromUID;
    UserModel productUser;
    sl.get<AuthMethod>().recieveUserData(uploaderID).then((value) async {
      productUser = value;

      List<String> persons = [];
      persons.add(productUser.id!);
      persons.add(sl.get<AuthMethod>().currentUserData!.id!);

      Chat chat = await ChatAPI().createChat(
          notificationData.fromUID + sl.get<AuthMethod>().currentUserData!.id!,
          persons);
      // ignore: use_build_context_synchronously
      // Chat asd = await sl.get<ChatAPI>().getchat(notificationData.chatId!);
      // print(asd.chatID);
      // ignore: use_build_context_synchronously
      // TODO: fix_chat_duplication_problemc
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PersonalChatScreen(
            chat: chat,
            url: notificationData.type.json == 'search'
                ? notificationData.imgUrl
                : null,
            chatWith: sl.get<UserProvider>().user(
                  uid: notificationData.fromUID,
                ));
      }));
    });
  }
}
