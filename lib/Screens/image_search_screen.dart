import 'dart:typed_data';
import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/services/databse_storage.dart';
import 'package:automobile_management/utilities/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:uuid/uuid.dart';

import '../Common/constants.dart';
import '../databases/notification_service.dart';
import '../models/device_token.dart';
import '../providers/user/user_provider.dart';
import '../services/location_api.dart';

class ImageSearchScreen extends StatefulWidget {
  const ImageSearchScreen({super.key});

  @override
  State<ImageSearchScreen> createState() => _ImageSearchScreenState();
}

class _ImageSearchScreenState extends State<ImageSearchScreen> {
  final LocationApi locationApi = sl.get<LocationApi>();
  Uint8List? _image;
  bool _isloading = false;
  AuthMethod authMethod = sl.get<AuthMethod>();

  final _formKey = GlobalKey<FormState>();

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  void sendImageSearchNotification(String imageurl) async {
    List<String> followersList =
        authMethod.currentUserData!.followers.cast<String>();
    List<MyDeviceToken> followerTokens = sl
        .get<UserProvider>()
        .deviceTokensFromListOfString(uidsList: followersList);
    for (var i = 0; i < followersList.length; i++) {
      await authMethod.addNotifications(
          postId: Uuid().v4(),
          announcementTitle:
              "${authMethod.currentUserData!.username} Just Searched for a product",
          imageUrl: imageurl,
          eachUserId: followersList[i],
          eachUserToken: followerTokens[i].token,
          description: 'Do you have this Product?');
    }
    NotificationsServices().sendSubsceibtionNotification(
        deviceToken: followerTokens,
        messageTitle:
            "${authMethod.currentUserData!.username} Just Searched for a product",
        messageBody: imageurl,
        data: <String>['Product Search', 'Image Search', 'Search']);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> uploadImageAndSendNotifications() async {
      if (_formKey.currentState!.validate() && _image != null) {
        setState(() {
          _isloading = true;
        });
        String imageId = const Uuid().v4();
        String imageurl = await Storagemethod().uploadtostorage(
          'search',
          '${authMethod.currentUserData!.id.toString()}-$imageId',
          _image!,
        );
        sendImageSearchNotification(imageurl);
        setState(() {
          _isloading = false;
        });
        Navigator.pop(context);
      } else {
        CustomToast.errorToast(
            message: "Please Upload an Image ", duration: 10);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: textFieldColor,
                      foregroundColor: Colors.black,
                      fixedSize: const Size.fromRadius(30),
                      elevation: 0,
                    ),
                    child: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: textFieldColor.withOpacity(0),
          foregroundColor: textColor,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Image Search",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(
                                1, 1), // changes position of shadow
                          ),
                        ], borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                              size: const Size.fromRadius(90),
                              child: _image != null
                                  ? Stack(
                                      children: <Widget>[
                                        Container(
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: MemoryImage(_image!),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 25.0, top: 20),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                selectImage();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                backgroundColor: textFieldColor,
                                                foregroundColor: Colors.black,
                                                fixedSize:
                                                    const Size.fromRadius(15),
                                                elevation: 0,
                                              ),
                                              child: const Icon(CupertinoIcons
                                                  .add_circled_solid),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        selectImage();
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.add_circle_outline_outlined,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Add Photo")
                                          ],
                                        ),
                                      ),
                                    )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          await uploadImageAndSendNotifications();
                        },
                        child: Container(
                          height: 55,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _isloading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      ' Search',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
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
          ),
        ),
      ),
    );
  }

  Widget textField(
      BuildContext context, TextEditingController controller, String hint) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          // starticon: Icons.person,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: hintTextColor),
          ),
          // validator: (String? value) => CustomValidator.isEmpty(value),
        ),
      ],
    );
  }
}
