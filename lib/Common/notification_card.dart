import 'package:automobile_management/Common/reusable_card.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class NotificationCard extends StatelessWidget {
  final String username;
  final String notificationText;
  final Widget? userProfileImage;
  final VoidCallback? onPressed;
  final String time;
  const NotificationCard({
    super.key,
    this.username = "Toxic",
    this.userProfileImage,
    this.notificationText =
        "Lorem ipsum dolor sit amet consectetur. Sed egestas egestas condimentum aliqu.",
    this.onPressed,
    this.time = "2:30 pm",
  });

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      onPress: onPressed,
      cardPaddinng: 20,
      colour: textFieldColor,
      cardChild: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: userProfileImage,
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
                      Text(
                        username,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Text(
                          time,
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
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
