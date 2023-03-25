import 'package:automobile_management/Screens/signin_screen.dart';
import 'package:automobile_management/Widgets/custom_toast.dart';
import 'package:automobile_management/models/signup_controller.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Common/constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? status;
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignUpController>(context);
    var scaffold = Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isVendor) {
                            isVendor = false;
                            swapColors();
                          }
                        });
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: userModeContainerColor,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Sigin Up as Seller',
                              style: TextStyle(
                                  color: userModeTextColor, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!isVendor) {
                            isVendor = true;
                            swapColors();
                          }
                        });
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: vendorModeContainerColor,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Sigin Up as Vendor',
                              style: TextStyle(
                                  color: vendorModeTextColor, fontSize: 18),
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
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: textFieldColor,
                        ),
                        padding: const EdgeInsets.only(left: 16),
                        child: TextField(
                          style: const TextStyle(color: textColor),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
                            hintStyle: TextStyle(color: hintTextColor),
                          ),
                          controller: controller.username,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: textFieldColor,
                        ),
                        padding: const EdgeInsets.only(left: 16),
                        child: TextField(
                          style: const TextStyle(color: textColor),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(color: hintTextColor),
                          ),
                          controller: controller.email,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: textFieldColor,
                        ),
                        padding: const EdgeInsets.only(left: 16),
                        child: TextField(
                          style: const TextStyle(color: textColor),
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(color: hintTextColor),
                          ),
                          controller: controller.password,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: textFieldColor,
                        ),
                        padding: const EdgeInsets.only(left: 16),
                        child: TextField(
                          style: const TextStyle(color: textColor),
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(color: hintTextColor),
                          ),
                          controller: controller.confirmPassword,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            registerUser(controller, context);
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
                                child: status == "loading"
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        ' Sign Up',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I already have an account ',
                              style: TextStyle(
                                  color: textColor.withAlpha(150),
                                  fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen(),
                                    ));
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return scaffold;
  }

  Future<void> registerUser(
      SignUpController controller, BuildContext context) async {
    setState(() {
      status = "loading";
    });
    final user = UserModel(
      username: controller.username.text.trim(),
      email: controller.email.text.trim(),
      isVendor: isVendor,
      password: controller.password.text.trim(),
    );

    status = await SignUpController().crateUser(context, user);
    await Future.delayed(const Duration(seconds: 1));
    if (status == 'success') {
      CustomToast.successToast(message: status!);
      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    } else
      (CustomToast.errorToast(message: status!));
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
