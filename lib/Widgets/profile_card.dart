import 'dart:ffi';

import 'package:automobile_management/Widgets/reusable_card.dart';
import 'package:flutter/material.dart';

import '../Common/constants.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final String notificationText;
  final Widget? userProfileImage;
  final VoidCallback? onPressed;
  final String followers;
  double height = 100;
  double width = 100;

  ProfileCard({
    super.key,
    this.username = "Toxic",
    this.userProfileImage,
    this.notificationText =
        "Lorem ipsum dolor sit amet consectetur. Sed egestas egestas condimentum aliqu.",
    this.onPressed,
    this.height = 460,
    this.width = 300,
    this.followers = "2.7 K",
  });

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      cardWidth: width,
      cardHeight: height,
      onPress: onPressed,
      colour: textFieldColor,
      cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child:
                  Container(width: double.maxFinite, child: userProfileImage!),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          username,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          followers,
                          style: TextStyle(color: textColor.withOpacity(0.5)),
                        ),
                      )
                    ],
                  ),
                  Flexible(
                    child: Text(
                      notificationText,
                      style: TextStyle(color: textColor.withOpacity(0.5)),
                      softWrap: true,
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}
