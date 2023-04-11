import 'package:automobile_management/widgets/reusable_card.dart';
import 'package:flutter/material.dart';

import '../Common/constants.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final String notificationText;
  final String buttonText;
  final Widget? userProfileImage;
  final VoidCallback? onPressed;
  final VoidCallback? onButtonPressed;

  final String followers;
  double height = 100;
  double width = 100;
  double cardElevation;

  ProfileCard({
    super.key,
    this.username = "Toxic",
    this.userProfileImage,
    this.buttonText = "Follow",
    this.notificationText =
        "Lorem ipsum dolor sit amet consectetur. Sed egestas egestas condimentum aliqu.",
    this.onPressed,
    this.onButtonPressed,
    this.height = 460,
    this.width = 300,
    this.followers = "2.7 K",
    this.cardElevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      elevation: cardElevation,
      cardWidth: width,
      cardHeight: height,
      onPress: onPressed,
      colour: textFieldColor,
      cardChild: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: double.maxFinite,
                      child: userProfileImage!,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10))),
                ),
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
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              heightFactor: 1,
              widthFactor: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 2, left: 5),
                child: SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: textFieldColor,
                      foregroundColor: textFieldColor,
                      elevation: 5,
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
