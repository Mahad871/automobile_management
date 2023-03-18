import 'package:automobile_management/Common/custom_rounded_button.dart';
import 'package:automobile_management/Common/reusable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(CupertinoIcons.person_alt,
                                    color: Colors.black),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Mahad Saleem",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: const [
                                    Icon(CupertinoIcons.heart_solid, size: 15),
                                    Text("3.1 k")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    side: const BorderSide(
                                        style: BorderStyle.solid)),
                                onPressed: () {},
                                child: const Icon(Icons.notifications)),
                            ElevatedButton(
                              onPressed: () {},
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
    );

    return scaffold;
  }
}
