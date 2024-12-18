import 'package:automobile_management/Screens/notificastion_page.dart';
import 'package:automobile_management/Screens/profile_screen.dart';
import 'package:automobile_management/Screens/search_page.dart';
import 'package:automobile_management/Screens/signin_screen.dart';
import 'package:automobile_management/Screens/upload_screen.dart';
import 'package:automobile_management/providers/user/user_provider.dart';
import 'package:automobile_management/services/location_api.dart';
import 'package:automobile_management/widgets/reusable_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../Common/constants.dart';
import '../databases/chat_api.dart';
import '../dependency_injection/injection_container.dart';
import '../models/auth_method.dart';
import '../models/chat/chat.dart';
import '../models/user_model.dart';
import 'chat_screens/personal_chat_page/personal_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = "error";
  String postOrientation = "grid";
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;
  final GetStorage _storage = GetStorage();
  List<Chat> chatsList = [];

  @override
  Widget build(BuildContext context) {
    AuthMethod authMethod = sl.get<AuthMethod>();
    // sl.get<UserProvider>().init();
    var position = sl.get<LocationApi>().determinePosition();

    var scaffold = Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChangeNotifierProvider<AuthMethod>.value(
                        value: sl.get<AuthMethod>(),
                        child: Consumer<AuthMethod>(
                          builder: (context, value, child) => Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CachedNetworkImage(
                                  imageUrl: authMethod
                                              .currentUserData?.photoUrl !=
                                          null
                                      ? authMethod.currentUserData!.photoUrl
                                          .toString()
                                      : defualtUserImg,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.all(5.0),
                              //   child: Container(
                              //     width: 45.0,
                              //     height: 45.0,
                              //     decoration: BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       color: textFieldColor,
                              //       image: DecorationImage(
                              //           fit: BoxFit.cover,
                              //           image:
                              //               ? CachedNetworkImageProvider(
                              //                   errorListener: () {
                              //                   CachedNetworkImageProvider(
                              //                     "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                              //                   );
                              //                 },
                              //                   authMethod
                              //                       .currentUserData!.photoUrl
                              //                       .toString())
                              //               : const CachedNetworkImageProvider(
                              //                   "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                              //                 )),
                              //     ),
                              //   ),
                              // ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    authMethod.currentUserData?.username == null
                                        ? "Loading..."
                                        : authMethod.currentUserData!.username
                                            .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: const [
                                      Icon(CupertinoIcons.heart_solid,
                                          size: 15),
                                      Text("3.1 k")
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                      style: BorderStyle.solid)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen(),
                                ));
                              },
                              child: const Icon(Icons.notifications)),
                          ElevatedButton(
                            onPressed: () {
                              authMethod.signOutUser();
                              _storage.remove('mail');
                              _storage.remove('pass');
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                  (route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder()),
                            child: const Text('+ User'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const SearchScreen(title: "Toxic\nOnline"),
                        )),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              color: textFieldColor),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("| Search",
                                  style: TextStyle(
                                      color: textColor, fontSize: 18)),
                              Icon(CupertinoIcons.mic_fill)
                            ],
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: textFieldColor,
                        foregroundColor: Colors.black,
                        fixedSize: const Size.fromRadius(25),
                        elevation: 0,
                      ),
                      child: const Icon(Icons.person_2_outlined),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: textFieldColor,
                        foregroundColor: Colors.black,
                        fixedSize: const Size.fromRadius(25),
                        elevation: 0,
                      ),
                      child: const Icon(Icons.storefront_sharp),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UploadScreen(),
                            ),
                          );
                        },
                        colour: textFieldColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              CupertinoIcons.photo_fill,
                              size: 40,
                            ),
                            Text("Add Picture here")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 220,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: ChatAPI().getAllChats(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      }

                      // Clear the chats list
                      chatsList.clear();

                      // Add chats to the list
                      for (var doc in snapshot.data?.docs ?? []) {
                        List<String> participants =
                            List<String>.from(doc["persons"]);
                        Chat currentChat = Chat(
                          isGroup: false,
                          chatID: doc["chat_id"],
                          persons: participants,
                        );
                        if (!chatsList.contains(currentChat)) {
                          chatsList.add(currentChat);
                        }
                      }

                      return Column(
                        children: [
                          const ReusableCard(
                            cardHeight: 40,
                            cardWidth: double.infinity,
                            colour: textFieldColor,
                            cardChild: Center(
                              child: Text(
                                "Recent Chats",
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                              ),
                              itemCount: chatsList.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Chat currentChat = chatsList[index];
                                List<String> participants = currentChat.persons;

                                List<UserModel> listUsers = sl
                                    .get<UserProvider>()
                                    .usersFromListOfString(
                                      uidsList: participants,
                                    );

                                String? userPic = listUsers[0].id !=
                                        sl.get<AuthMethod>().currentUserData?.id
                                    ? listUsers[0].photoUrl
                                    : listUsers[1].photoUrl;

                                return GridTile(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalChatScreen(
                                            chat: currentChat,
                                            chatWith: listUsers[0].id !=
                                                    sl
                                                        .get<AuthMethod>()
                                                        .currentUserData
                                                        ?.id
                                                ? listUsers[0]
                                                : listUsers[1],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                const CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                        imageUrl: userPic ??
                                            "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-portrait-176256935.jpg",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
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
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    return scaffold;
  }
}

// StreamBuilder(
//                   stream: authMethod.db.collection('product').snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (!snapshot.hasData) {
//                       return const ReusableCard(
//                         colour: textFieldColor,
//                         cardChild: Icon(Icons.photo),
//                         cardWidth: 280,
//                       );
//                     }
//                     final List<DocumentSnapshot> documents =
//                         snapshot.data!.docs;
//                     return GridView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: documents.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final String url = documents[index]['image_url'];
//                         final String productName =
//                             documents[index]['product_name'];

//                         return Stack(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Container(
//                                 height: 200,
//                                 // width: double.maxFinite,
//                                 decoration: BoxDecoration(boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(1),
//                                     spreadRadius: 0,
//                                     blurRadius: 8,
//                                     offset: const Offset(
//                                         1, 1), // changes position of shadow
//                                   ),
//                                 ], borderRadius: BorderRadius.circular(20)),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: SizedBox.fromSize(
//                                       size: const Size.fromRadius(90),
//                                       child: CachedNetworkImage(
//                                         imageUrl: url,
//                                         placeholder: (context, url) =>
//                                             const Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 120, vertical: 45),
//                                           child: CircularProgressIndicator(
//                                             color: textColor,
//                                           ),
//                                         ),
//                                         errorWidget: (context, url, error) =>
//                                             Text(
//                                           error,
//                                           style:
//                                               const TextStyle(color: textColor),
//                                         ),
//                                         fit: BoxFit.cover,
//                                       )),
//                                 ),
//                               ),
//                             ),
//                             Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       right: 25.0, top: 20),
//                                   child: ElevatedButton(
//                                     onPressed: () {},
//                                     style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       backgroundColor: textFieldColor,
//                                       foregroundColor: Colors.black,
//                                       fixedSize: const Size.fromRadius(15),
//                                       elevation: 0,
//                                     ),
//                                     child: Text(
//                                       productName,
//                                       style: const TextStyle(color: textColor),
//                                     ),
//                                   ),
//                                 ))
//                           ],
//                         );
//                       },
//                     );
//                   },
//                 )
