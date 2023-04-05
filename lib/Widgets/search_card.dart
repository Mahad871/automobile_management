import 'package:automobile_management/Widgets/reusable_card.dart';
import 'package:flutter/material.dart';

import '../Common/constants.dart';

class SearchCard extends StatelessWidget {
  final String username;
  final String notificationText;
  final Widget? userProfileImage;
  final Widget topIcon = Icon(Icons.pause);
  final Widget cardIcon = Icon(Icons.arrow_forward);

  final VoidCallback? onPressed;
  final VoidCallback? onCardIconPressed;
  final VoidCallback? onTopIconPressed;
  final String time;
  double height = 100;
  double width = 100;

  SearchCard({
    super.key,
    this.username = "Toxic",
    this.userProfileImage,
    this.notificationText =
        "Lorem ipsum dolor sit amet consectetur. Sed egestas egestas condimentum aliqu.",
    this.onPressed,
    this.onCardIconPressed,
    this.onTopIconPressed,
    this.height = 100,
    this.width = 100,
    this.time = "2:30 pm",
  });

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      cardWidth: width,
      cardHeight: height,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                              style:
                                  TextStyle(color: textColor.withOpacity(0.5)),
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
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: cardIcon,
                  )
                ],
              ),
            )
          ]),
    );
  }
}
