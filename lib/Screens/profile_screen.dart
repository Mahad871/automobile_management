import 'dart:typed_data';
import 'package:automobile_management/Screens/signup_screen.dart';
import 'package:automobile_management/providers/profile_controller.dart';
import 'package:automobile_management/utilities/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Common/constants.dart';
import '../dependency_injection/injection_container.dart';
import '../models/user_model.dart';
import 'package:provider/provider.dart';

import '../models/auth_method.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;
  bool usernameFieldDisabled = true;
  bool emailFieldDisabled = true;
  bool phoneNoFieldDisabled = true;
  bool passwordFieldDisabled = true;
  Uint8List? _image;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthMethod authMethod = sl.get<AuthMethod>();
    ProfileProvider controller = sl.get<ProfileProvider>();
    controller.email.text = authMethod.currentUserData!.email;
    controller.password.text = authMethod.currentUserData!.password;
    controller.username.text = authMethod.currentUserData!.username;

    var scaffold = Scaffold(
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
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Picture",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: <Widget>[
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
                              child: ChangeNotifierProvider<AuthMethod>.value(
                                value: authMethod,
                                child: Consumer<AuthMethod>(
                                  builder: (context, value, child) => ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(90),
                                      child: authMethod
                                                  .currentUserData!.photoUrl !=
                                              null
                                          ? CachedNetworkImage(
                                              imageUrl: authMethod
                                                  .currentUserData!.photoUrl!,
                                              placeholder: (context, url) =>
                                                  const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 120,
                                                    vertical: 45),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: textColor,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) => Text(
                                                error,
                                                style: const TextStyle(
                                                    color: textColor),
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                              placeholder: (context, url) =>
                                                  const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 120,
                                                    vertical: 45),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: textColor,
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 25.0, top: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  selectImage();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: textFieldColor,
                                  foregroundColor: Colors.black,
                                  fixedSize: const Size.fromRadius(15),
                                  elevation: 0,
                                ),
                                child: const Icon(CupertinoIcons.pencil),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Bio",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Username",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: textFieldColor,
                      ),
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        readOnly: usernameFieldDisabled,
                        controller: controller.username,
                        style: const TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: const TextStyle(color: hintTextColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                usernameFieldDisabled = !usernameFieldDisabled;
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Email",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: textFieldColor,
                      ),
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        readOnly: emailFieldDisabled,
                        controller: controller.email,
                        style: const TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: const TextStyle(color: hintTextColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                emailFieldDisabled = !emailFieldDisabled;
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Phone no",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: textFieldColor,
                      ),
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        readOnly: phoneNoFieldDisabled,
                        controller: controller.phoneNo,
                        style: const TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: const TextStyle(color: hintTextColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                phoneNoFieldDisabled = !phoneNoFieldDisabled;
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Password",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: textFieldColor,
                      ),
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        obscureText: true,
                        readOnly: passwordFieldDisabled,
                        controller: controller.password,
                        style: const TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: const TextStyle(color: hintTextColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordFieldDisabled = !passwordFieldDisabled;
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Address",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: textFieldColor,
                      ),
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        readOnly: false,
                        controller: controller.address,
                        style: const TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: const TextStyle(color: hintTextColor),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_on),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          UserModel user = UserModel(
                            id: authMethod.currentUser!.user!.uid,
                            username: controller.username.text,
                            email: controller.email.text,
                            isVendor: isVendor,
                            password: controller.password.text,
                            file: _image,
                            followers: authMethod.currentUserData!.followers,
                            following: authMethod.currentUserData!.following,
                            deviceToken: [],
                            latitude: authMethod.currentUserData!.latitude,
                            longitude: authMethod.currentUserData!.longitude,
                          );
                          authMethod.currentUserData = user;
                          setState(() {
                            isloading = true;
                          });
                          await authMethod.updateUser();
                          isloading = false;
                          setState(() {});
                          Navigator.pop(context);
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
                                child: isloading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Update',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return scaffold;
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void navigateToRegistrationScreen(
    BuildContext context,
  ) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  void swapColors() {
    setState(() {
      Color temp = userModeContainerColor;
      userModeContainerColor = vendorModeContainerColor;
      vendorModeContainerColor = temp;
      temp = userModeTextColor;
      userModeTextColor = vendorModeTextColor;
      vendorModeTextColor = temp;
    });
  }
}
