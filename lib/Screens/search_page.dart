import 'package:automobile_management/Common/constants.dart';
import 'package:automobile_management/Screens/chat_list_page.dart';
import 'package:automobile_management/Screens/notificastion_page.dart';
import 'package:automobile_management/Widgets/notification_card.dart';
import 'package:automobile_management/Widgets/profile_card.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/product_model.dart';
import 'package:automobile_management/providers/base_view.dart';
import 'package:automobile_management/services/product_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../dependency_injection/injection_container.dart';
import '../models/SearchController.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.title});
  final String title;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // This controller will store the value of the search bar
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;
  final listUsers = sl.get<AuthMethod>().getAllUserData();
  final SearchController _searchController = sl.get<SearchController>();
  late PageController _pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1.0);
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
            child: Column(children: [
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ));
                    },
                    child: const Icon(Icons.mic)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            _pageController = PageController(
                                initialPage: 0,
                                keepPage: true,
                                viewportFraction: 1.0);
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
                            _pageController = PageController(
                                initialPage: 1,
                                keepPage: true,
                                viewportFraction: 1.0);
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
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: PageView(
                controller: _pageController,
                children: [
                  BaseView<ProductApi>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: value.product.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: NotificationCard(
                              time: "",
                              username: value.product[index].productname,
                              notificationText:
                                  value.product[index].amount.toString(),
                              userProfileImage:
                                  //  sl
                                  //         .get<AuthMethod>()
                                  //         .getUserData(snapshot.data!
                                  //             .docs[index]['created_by_uid']) !=
                                  //     null
                                  // ? CachedNetworkImage(
                                  //     imageUrl: listOfProducts[index].imageurl,
                                  //   )
                                  // :
                                  CachedNetworkImage(
                                imageUrl: value.product[index].imageurl,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    onModelReady: (p0) {},
                  ),
                  // FutureBuilder<QuerySnapshot>(
                  //   future:
                  //       FirebaseFirestore.instance.collection('product').get(),
                  //   builder: (BuildContext context,
                  //       AsyncSnapshot<QuerySnapshot> snapshot) {
                  //     if (snapshot.hasError) {
                  //       return const Text('Something went wrong');
                  //     }

                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const Text('Loading');
                  //     }
                  //     snapshot.data!.docs.forEach((element) {
                  //       listOfProducts.add(Product.fromQuerySnapshot(element));
                  //     });
                  //     return ListView.builder(
                  //       physics: const BouncingScrollPhysics(),
                  //       itemCount: listOfProducts.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return ListTile(
                  //           title: NotificationCard(
                  //             time: "",
                  //             username: listOfProducts[index].productname,
                  //             notificationText:
                  //                 listOfProducts[index].amount.toString(),
                  //             userProfileImage: sl
                  //                         .get<AuthMethod>()
                  //                         .getUserData(snapshot.data!
                  //                             .docs[index]['created_by_uid']) !=
                  //                     null
                  //                 ? CachedNetworkImage(
                  //                     imageUrl: listOfProducts[index].imageurl,
                  //                   )
                  //                 : CachedNetworkImage(
                  //                     imageUrl: listOfProducts[index].imageurl,
                  //                   ),
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading');
                      }

                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GridTile(
                                child: Column(
                              children: [
                                snapshot.data!.docs[index]['photoUrl'] != null
                                    ? Flexible(
                                        child: ProfileCard(
                                          notificationText: "",
                                          username: snapshot.data!.docs[index]
                                              ['username'],
                                          userProfileImage: CachedNetworkImage(
                                            imageUrl: snapshot.data!.docs[index]
                                                ['photoUrl'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Flexible(
                                        child: ProfileCard(
                                          notificationText: "",
                                          username: snapshot.data!.docs[index]
                                              ['username'],
                                          userProfileImage: CachedNetworkImage(
                                            imageUrl:
                                                "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                              ],
                            ));
                          });
                    },
                  ),
                ],
              ),
            ),
          )
        ])));
  }

  getImage(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) async {
    String uid = snapshot.data!.docs[index]['created_by_uid'];
    String ans = "none";
    print('uid ' + uid);

    DocumentSnapshot snapshott =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    Map<String, dynamic> data = snapshott.data() as Map<String, dynamic>;
    String result = data.toString();
    print(result.toString());
    return result;
  }
}
