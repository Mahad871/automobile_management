import 'package:automobile_management/widgets/reusable_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../Common/constants.dart';

class SearchCard extends StatefulWidget {
  final String username;
  final String notificationText;
  final String? circularImageUrl;
  final VoidCallback? onPressed;
  final VoidCallback? onCardIconPressed;
  final VoidCallback? onTopIconPressed;
  final String time;
  double height = 100;
  double width = 100;
  double timer;
  bool iscardEnabled = true;

  SearchCard({
    super.key,
    this.timer = 10,
    this.username = "Toxic",
    this.circularImageUrl,
    this.notificationText =
        "Lorem ipsum dolor sit amet consectetur. Sed egestas egestas condimentum aliqu.",
    this.onPressed,
    this.onCardIconPressed,
    this.onTopIconPressed,
    this.height = 150,
    this.width = 100,
    this.time = "2:30 pm",
  });

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> with TickerProviderStateMixin {
  final Widget topIcon = Icon(Icons.pause);

  final Widget cardIcon = Icon(Icons.arrow_forward);
  late AnimationController controller;
  @override
  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.isCompleted
        ? empty()
        : ReusableCard(
            cardWidth: widget.width,
            cardHeight: widget.height,
            onPress: widget.onPressed,
            cardPaddinng: 20,
            colour: textFieldColor,
            cardChild: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.circularImageUrl != null
                              ? widget.circularImageUrl.toString()
                              : "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 55,
                            height: 55,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.username,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 22),
                                      child: Text(
                                        widget.time,
                                        style: TextStyle(
                                            color: textColor.withOpacity(0.5)),
                                      ),
                                    )
                                  ],
                                ),
                                Flexible(
                                  child: SizedBox(
                                    width: 150,
                                    child: Text(
                                      widget.notificationText,
                                      style: TextStyle(
                                          color: textColor.withOpacity(0.5)),
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      backgroundColor: textFieldColor,
                                      foregroundColor: textColor,
                                      elevation: 5,
                                    ),
                                    child: cardIcon),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: LinearProgressIndicator(
                          color: Colors.black,
                          value: controller.value,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 35,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                print(controller.value);
                                controller.stop();
                              });
                            },
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
                  ],
                ),
              ],
            ),
          );
  }

  SizedBox empty() {
    widget.iscardEnabled = false;
    return const SizedBox(
      height: 1,
      width: 1,
    );
  }
}
