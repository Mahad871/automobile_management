import 'dart:async';

import 'package:automobile_management/Common/constants.dart';
// import 'package:automobile_management/Screens/chat/screens/mobile_chat_screen.dart';
import 'package:automobile_management/Screens/chat_list_page.dart';
import 'package:automobile_management/Screens/google_map.dart';
import 'package:automobile_management/Screens/image_search_screen.dart';
import 'package:automobile_management/Screens/notificastion_page.dart';
import 'package:automobile_management/Widgets/custom_toast.dart';
import 'package:automobile_management/Widgets/reusable_card.dart';
import 'package:automobile_management/databases/chat_api.dart';
import 'package:automobile_management/databases/notification_api.dart';
import 'package:automobile_management/databases/notification_service.dart';
import 'package:automobile_management/models/chat/chat.dart';
import 'package:automobile_management/models/device_token.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/providers/SearchController.dart';
import 'package:automobile_management/providers/user/user_provider.dart';
import 'package:automobile_management/screens/chat_screens/personal_chat_page/personal_chat_screen.dart';
import 'package:automobile_management/widgets/profile_card.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/providers/base_view.dart';
import 'package:automobile_management/services/product_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../widgets/search_card.dart';
import '../dependency_injection/injection_container.dart';
// import 'chat/repositories/chat_repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.title});
  final String title;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  // This controller will store the value of the search bar
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;
  final listUsers = sl.get<AuthMethod>().getAllUserData();
  final SearchController _searchController = sl.get<SearchController>();
  late TabController _pageController;
  AuthMethod authMethod = sl.get<AuthMethod>();
  int _tab = 0;

  void swapColors() {
    setState(() {
      Color temp = userModeContainerColor;
      userModeContainerColor = vendorModeContainerColor;
      vendorModeContainerColor = temp;
      temp = userModeTextColor;
      userModeTextColor = vendorModeTextColor;
      vendorModeTextColor = temp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<ProductApi>().getdata();
    _pageController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: textColor,
        toolbarHeight: 70,
        shadowColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        fixedSize: const Size.fromRadius(22),
                        side: const BorderSide(style: BorderStyle.solid)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChatListScreen(),
                      ));
                    },
                    child: const Icon(Icons.chat_rounded)),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        fixedSize: const Size.fromRadius(22),
                        side: const BorderSide(style: BorderStyle.solid)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ));
                    },
                    child: const Icon(Icons.notifications)),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController.search,
                      onChanged: (value) async {
                        await sl<ProductApi>().getSearchResults(value);
                        // setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: '  Search',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _searchController.search.clear(),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 45),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromRadius(25),
                          shape: const CircleBorder(),
                          side: const BorderSide(style: BorderStyle.solid)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ImageSearchScreen(),
                            ));
                      },
                      child: const Icon(Icons.upload_file_sharp)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isVendor) {
                              isVendor = false;
                              swapColors();
                              _pageController.animateTo(0);
                              _tab = 0;
                            }
                          });
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: userModeContainerColor,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                ' My Group',
                                style: TextStyle(
                                    color: userModeTextColor, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!isVendor) {
                              isVendor = true;
                              swapColors();
                              _pageController.animateTo(1);
                              _tab = 1;
                            }
                          });
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: vendorModeContainerColor,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Radius',
                                style: TextStyle(
                                    color: vendorModeTextColor, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('product')
                              .snapshots(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (snapshot.hasError) {
                                  return const Text('Something went wrong');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ));
                                }
                                return ListTile(
                                  title: SearchCard(
                                    time: "",
                                    username: snapshot.data!.docs[index]
                                        ['product_name'],
                                    notificationText: snapshot.data!.docs[index]
                                        ['description'],
                                    circularImageUrl: snapshot.data!.docs[index]
                                        ['image_url'],
                                    onCardIconPressed: () =>
                                        createChat(snapshot, index, context),
                                  ),
                                );
                              },
                            );
                          }),
                      FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          }
                          double distance;
                          final QuerySnapshot<Map<String, dynamic>> users =
                              snapshot.data!;
                          List<UserModel> userModel = [];
                          List<String> isFollowed = [];
                          for (var e in users.docs) {
                            UserModel model = UserModel.fromDocumentSnapshot(e);
                            distance = Geolocator.distanceBetween(
                              authMethod.currentUserData?.latitude ?? 0.0,
                              authMethod.currentUserData?.longitude ?? 0.0,
                              model.latitude ?? 0.0,
                              model.longitude ?? 0.0,
                            );
                            if (distance < 3000) {
                              userModel.add(UserModel.fromDocumentSnapshot(e));
                              isFollowed.add(isUserFollowed(
                                  snapshot, userModel.last.id.toString()));
                            }
                          }

                          return Column(
                            children: [
                              ReusableCard(
                                cardHeight: 40,
                                cardWidth: double.infinity,
                                colour: textFieldColor,
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MapsPage(users: userModel),
                                      ));
                                },
                                cardChild: const Center(
                                  child: Text(
                                    "Vendors within 3 Km",
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: ChangeNotifierProvider.value(
                                  value: sl.get<AuthMethod>(),
                                  child: Consumer<AuthMethod>(
                                    builder: (context, value, child) =>
                                        GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      ),
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: userModel.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final user = userModel[index];
                                        distance = Geolocator.distanceBetween(
                                          authMethod
                                                  .currentUserData?.latitude ??
                                              0.0,
                                          authMethod
                                                  .currentUserData?.longitude ??
                                              0.0,
                                          user.latitude ?? 0.0,
                                          user.longitude ?? 0.0,
                                        );

                                        return GridTile(
                                          child: Column(
                                            children: [
                                              Flexible(
                                                child: ProfileCard(
                                                  buttonText: isFollowed[index],
                                                  onButtonPressed: () {
                                                    isFollowed[index] ==
                                                            "UnFollow"
                                                        ? authMethod
                                                            .unfollowUser(
                                                            followerUid: authMethod
                                                                .currentUserData!
                                                                .id
                                                                .toString(),
                                                            followingUid: user
                                                                .id
                                                                .toString(),
                                                          )
                                                        : authMethod.followUser(
                                                            followerUid: authMethod
                                                                .currentUserData!
                                                                .id
                                                                .toString(),
                                                            followingUid: user
                                                                .id
                                                                .toString(),
                                                          );
                                                    setState(() {
                                                      isFollowed[index] =
                                                          isUserFollowed(
                                                              snapshot,
                                                              userModel[index]
                                                                  .id
                                                                  .toString());
                                                    });
                                                  },
                                                  notificationText: distance
                                                      .round()
                                                      .toString(),
                                                  username: user.username,
                                                  userProfileImage:
                                                      CachedNetworkImage(
                                                    imageUrl: user.photoUrl ??
                                                        "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void sendImageSearchNotification() {
    List<String> followersList =
        authMethod.currentUserData!.followers.cast<String>();
    List<MyDeviceToken> followerTokens = sl
        .get<UserProvider>()
        .deviceTokensFromListOfString(uidsList: followersList);

    NotificationsServices().sendSubsceibtionNotification(
        deviceToken: followerTokens,
        messageTitle: "Product Search",
        messageBody:
            "${authMethod.currentUserData!.username} Just Searched for a product",
        data: <String>['Product Search', 'Image Search', 'Search']);
  }

  Future<void> createChat(AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      int index, BuildContext context) async {
    String uploaderID = snapshot.data!.docs[index]['created_by_uid'];
    UserModel productUser;
    sl.get<AuthMethod>().recieveUserData(uploaderID).then((value) async {
      productUser = value;

      List<String> persons = [];
      persons.add(productUser.id!);
      persons.add(authMethod.currentUserData!.id!);

      Chat chat = await ChatAPI().createChat(
          snapshot.data?.docs[index]['created_by_uid'] +
              authMethod.currentUserData?.id,
          persons);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PersonalChatScreen(chat: chat, chatWith: productUser),
        ),
      );
    });
  }

  String isUserFollowed(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, String uid) {
    if (authMethod.currentUserData!.noOfFollowing == 0 ||
        authMethod.currentUserData?.following == null) {
      return 'follow';
    }
    return authMethod.currentUserData!.following.contains(uid)
        ? "UnFollow"
        : "Follow";
  }

  // getImage(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) async {
  //   String uid = snapshot.data!.docs[index]['created_by_uid'];
  //   String ans = "none";
  //   print('uid ' + uid);

  //   DocumentSnapshot snapshott =
  //       await FirebaseFirestore.instance.collection('userModel').doc(uid).get();
  //   Map<String, dynamic> data = snapshott.data() as Map<String, dynamic>;
  //   String result = data.toString();
  //   print(result.toString());
  //   return result;
  // }
}
