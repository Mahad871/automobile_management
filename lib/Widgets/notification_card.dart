import 'package:automobile_management/widgets/reusable_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Common/constants.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  bool showBanner = false;
  final String body;
  final Widget? userProfileImage;
  final Widget? bannerImage;
  final VoidCallback? onPressed;
  final String time;
  double height = 100;
  double width = 100;

  NotificationCard(
      {super.key,
      this.title = "Toxic",
      this.userProfileImage,
      this.bannerImage,
      this.body =
          "Lorem ipsum dolor sit amet consectetur. Sed egestas egestas condimentum aliqu.",
      this.onPressed,
      this.height = 100,
      this.width = 100,
      this.time = "2:30 pm",
      this.showBanner = false});

  @override
  Widget build(BuildContext context) {
    if (showBanner) {
      height += 140;
    }
    return ReusableCard(
      cardWidth: width,
      cardHeight: height,
      onPress: onPressed,
      cardPaddinng: 20,
      colour: textFieldColor,
      cardChild: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: userProfileImage,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
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
                  // Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Container(
                  //       width: double.maxFinite,
                  //       decoration: BoxDecoration(boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(1),
                  //           spreadRadius: 0,
                  //           blurRadius: 8,
                  //           offset: const Offset(
                  //               1, 1), // changes position of shadow
                  //         ),
                  //       ], borderRadius: BorderRadius.circular(20)),
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(20),
                  //         child: SizedBox.fromSize(
                  //             size: const Size.fromRadius(90),
                  //             child:  Stack(
                  //                     children: <Widget>[
                  //                       Container(
                  //                         width: double.maxFinite,
                  //                         decoration: BoxDecoration(
                  //                           image: DecorationImage(
                  //                               image: MemoryImage(_image!),
                  //                               fit: BoxFit.cover),
                  //                         ),
                  //                       ),
                  //                       Align(
                  //                         alignment: Alignment.topRight,
                  //                         child: Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               right: 25.0, top: 20),
                  //                           child: ElevatedButton(
                  //                             onPressed: () {
                  //                               // selectImage();
                  //                             },
                  //                             style: ElevatedButton.styleFrom(
                  //                               shape: RoundedRectangleBorder(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(8),
                  //                               ),
                  //                               backgroundColor: textFieldColor,
                  //                               foregroundColor: Colors.black,
                  //                               fixedSize:
                  //                                   const Size.fromRadius(15),
                  //                               elevation: 0,
                  //                             ),
                  //                             child: const Icon(CupertinoIcons
                  //                                 .add_circled_solid),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   )

                  //                   ),
                  //       ),
                  //     ),
                  //   ),
                  Flexible(
                      child:
                          Visibility(visible: showBanner, child: bannerImage!)),
                  Flexible(
                    child: Text(
                      body,
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
