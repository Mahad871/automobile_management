import 'package:automobile_management/Screens/chat_list_page.dart';
import 'package:automobile_management/Screens/notificastion_page.dart';
import 'package:automobile_management/Screens/profile_screen.dart';
import 'package:automobile_management/Screens/search_page.dart';
import 'package:automobile_management/Screens/signin_screen.dart';
import 'package:automobile_management/Widgets/reusable_card.dart';
import 'package:automobile_management/models/profile_controller.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../Common/constants.dart';
import '../Widgets/custom_rounded_button.dart';
import '../dependency_injection/injection_container.dart';
import '../models/auth_method.dart';
import '../models/storage_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = "error";
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;
  final GetStorage _storage = GetStorage();

  @override
  void initState() {
    sl
        .get<AuthMethod>()
        .getCurrentUserData(_storage.read('user')['email'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthMethod authMethod = sl.get<AuthMethod>();

    var scaffold = Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                                  child: Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: textFieldColor,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: authMethod
                                                      .currentUserData?.photoUrl
                                                      .toString() !=
                                                  null
                                              ? CachedNetworkImageProvider(
                                                  authMethod
                                                      .currentUserData!.photoUrl
                                                      .toString())
                                              : const CachedNetworkImageProvider(
                                                  "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                )),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      authMethod.currentUserData?.username ==
                                              null
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SignInScreen()));
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
                  Row(
                    children: [
                      Expanded(
                        child: ReusableCard(
                          colour: textFieldColor,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "3.0M",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35),
                              ),
                              Text(
                                "Active Users",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          colour: textFieldColor,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "48M",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35),
                              ),
                              Text(
                                "Searched",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          colour: textFieldColor,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "1.3K",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35),
                              ),
                              Text(
                                "Active Pin",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                      CustomRoundButton(
                        buttonIcon: Icons.add,
                        buttonIconColor: textFieldColor,
                        buttonColor: textColor,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authMethod.signOutUser();
          _storage.remove('user');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
              (route) => false);
        },
        backgroundColor: textColor,
        child: const Icon(Icons.logout),
      ),
    );

    return scaffold;
  }
}
