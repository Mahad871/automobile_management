import 'package:automobile_management/Widgets/reusable_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Common/constants.dart';

class SearchCard extends StatelessWidget {
  final String username;
  final String notificationText;
  final String? circularImageUrl;
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
    this.circularImageUrl,
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CachedNetworkImage(
                imageUrl: circularImageUrl != null
                    ? circularImageUrl.toString()
                    : "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                imageBuilder: (context, imageProvider) => Container(
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: 50,
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () => onTopIconPressed,
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: textFieldColor,
                                      foregroundColor: textColor,
                                      elevation: 5,
                                    ),
                                    child: topIcon),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor: textFieldColor,
                                    foregroundColor: textColor,
                                    elevation: 5,
                                  ),
                                  child: cardIcon),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}
