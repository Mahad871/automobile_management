
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:automobile_management/Common/constants.dart';
import 'package:automobile_management/Screens/chat_dead/controller/chat_controller.dart';
import 'package:automobile_management/Screens/chat_dead/screens/mobile_chat_screen.dart';
import 'package:automobile_management/models/chat_contact.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/utilities/utils.dart';
import 'package:automobile_management/widgets/loader.dart';
List<UserModel> allUsers = [];

class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // StreamBuilder<List<Group>>(
            //     stream: ref.watch(chatControllerProvider).chatGroups(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Loader();
            //       }

            //       return ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: snapshot.data!.length,
            //         itemBuilder: (context, index) {
            //           var groupData = snapshot.data![index];
                      
            //           return Column(
            //             children: [
            //               InkWell(
            //                 onTap: () {
            //                   Navigator.pushNamed(
            //                     context,
            //                     MobileChatScreen.routeName,
            //                     arguments: {
            //                       'name': groupData.name,
            //                       'uid': groupData.groupId,
            //                       'isGroupChat': true,
            //                       'profilePic': groupData.groupPic,
            //                     },
            //                   );
            //                 },
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(bottom: 8.0),
            //                   child: ListTile(
            //                     title: Text(
            //                       groupData.name,
            //                       style: const TextStyle(
            //                         fontSize: 18,
            //                       ),
            //                     ),
            //                     subtitle: Padding(
            //                       padding: const EdgeInsets.only(top: 6.0),
            //                       child: Text(
            //                         groupData.lastMessage,
            //                         style: const TextStyle(fontSize: 15),
            //                       ),
            //                     ),
            //                     leading: CircleAvatar(
            //                       backgroundImage: NetworkImage(
            //                         groupData.groupPic,
            //                       ),
            //                       radius: 30,
            //                     ),
            //                     trailing: Text(
            //                       DateFormat.Hm().format(groupData.timeSent),
            //                       style: const TextStyle(
            //                         color: Colors.grey,
            //                         fontSize: 13,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               const Divider(color: dividerColor, indent: 85),
            //             ],
            //           );
            //         },
            //       );
            //     }),
           
            StreamBuilder<List<ChatContact>>(
                stream: 
                // FirebaseFirestore.instance
                //     .collection('users')
                //     .snapshots(),
                     ref.watch(chatControllerProvider).chatContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  // allUsers.clear();
                  // snapshot.data!.docs.forEach((element) {
                  //   allUsers.add(UserModel.fromDocument(element));
                  // });
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var chatContactData = snapshot.data![index];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              resetCounter();
                              Navigator.pushNamed(
                                context,
                                MobileChatScreen.routeName,
                                arguments: {
                                  'name': allUsers[index].username,
                                  'uid': allUsers[index].id,
                                  'isGroupChat': false,
                                  'profilePic': allUsers[index].photoUrl,
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                title: Text(
                                  allUsers[index].username,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: const Padding(
                                  padding: EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    'lastMessage',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    allUsers[index].photoUrl!,
                                  ),
                                  radius: 30,
                                ),
                                trailing: const Text(
                                  '123',
                                  // DateFormat.Hm()
                                  //     .format(timeSent),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(color: dividerColor, indent: 85),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
