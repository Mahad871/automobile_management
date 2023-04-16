import 'package:automobile_management/Screens/forget_password_screen.dart';
import 'package:automobile_management/Screens/home_page.dart';
import 'package:automobile_management/Screens/signup_screen.dart';
import 'package:automobile_management/databases/notification_service.dart';
import 'package:automobile_management/models/device_token.dart';
import 'package:automobile_management/providers/signin_controller.dart';
import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../Common/constants.dart';
import '../dependency_injection/injection_container.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isVendor = false;
  Color userModeContainerColor = Colors.black;
  Color userModeTextColor = Colors.white;
  Color vendorModeContainerColor = textFieldColor;
  Color vendorModeTextColor = Colors.black;
  String status = " ";
  GetStorage storage = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthMethod authMethod = sl.get<AuthMethod>();
    final controller = sl.get<SignInController>();
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
                        "Sign in",
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
                              ' Login as Seller',
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
                              'Login as Vendor',
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
                            hintText: "Email/Username",
                            hintStyle: TextStyle(color: hintTextColor),
                          ),
                          controller: controller.email,
                        ),
                      ),
                      const SizedBox(height: 15),
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
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(color: hintTextColor),
                          ),
                          controller: controller.password,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen()));
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            signUser(authMethod, controller, context);
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
                                        ' Log In',
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
                              'Don\'t have an account? ',
                              style: TextStyle(
                                  color: textColor.withAlpha(150),
                                  fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigateToRegistrationScreen(context);
                              },
                              child: const Text(
                                'Register',
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

  Future<void> signUser(AuthMethod authMethod, SignInController controller,
      BuildContext context) async {
    setState(() {
      status = "loading";
    });
    status = await authMethod.signinUser(
        email: controller.email.text.trim(),
        password: controller.password.text.trim());
    if (status == "success") {
      await authMethod.getCurrentUserData(controller.email.text.trim());
      CustomToast.successToast(message: "Success");
      String token = await NotificationsServices.getToken() ?? "";

      print("Device Token ## " + token);
      List<MyDeviceToken> deviceToken = [];
      deviceToken.add(MyDeviceToken(token: token));
      authMethod.setDeviceToken(deviceToken);
      // localStorage.storeUserData(authMethod.currentUserData!);
      // storage.write('user', authMethod.currentUserData);
      if (context.mounted) {
        authMethod.writeUserdataOnStorage();
        controller.email.clear();
        controller.password.clear();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      }
    } else {
      CustomToast.errorToast(message: status);
      setState(() {});
    }
  }

  // void checkIfUserLoggedIn(AuthMethod authMethod, StorageProvider localStorage,
  //     BuildContext context) async {
  //   if (localStorage.islogged) {
  //     authMethod.currentUserData = GetStorage().read('user');
  //     await authMethod.signinUser(
  //         email: authMethod.currentUserData!.email,
  //         password: authMethod.currentUserData!.password);
  //   }
  //   if (context.mounted) {
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const HomeScreen(),
  //         ));
  //   }
  // }

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
