import 'package:automobile_management/Screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Common/constants.dart';
import '../models/profile_controller.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  UserModel currentUser;
  ProfileScreen({super.key, required this.currentUser});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;
  ProfileController controller = Get.put(ProfileController());
  bool usernameFieldDisabled = true;
  bool emailFieldDisabled = true;
  bool phoneNoFieldDisabled = true;
  bool passwordFieldDisabled = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      controller.email.text = widget.currentUser.email;
      controller.password.text = widget.currentUser.password;
      controller.username.text = widget.currentUser.username;
    });

    super.initState();
  }

  Widget build(BuildContext context) {
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(90),
                                  child: Image.asset('assets/images/pic1.jpg',
                                      fit: BoxFit.cover),
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
                                  onPressed: () {},
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
                              ))
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
                            onPressed: () {
                              setState(() {});
                            },
                            icon: const Icon(Icons.location_on),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.updateUser(UserModel(
                              id: widget.currentUser.id,
                              username: controller.username.text.trim(),
                              email: controller.email.text.trim(),
                              isVendor: widget.currentUser.isVendor,
                              password: controller.password.text.trim()));
                              
                        },
                        child: Container(
                          height: 55,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black,
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Update',
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
          ],
        ),
      ),
    );

    return scaffold;
  }

  void navigateToRegistrationScreen(
    BuildContext context,
  ) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const RegistrationScreen()));
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
