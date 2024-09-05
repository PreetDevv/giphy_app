import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qt_giphy_test_preet/Constants/AppTheme.dart';
import 'package:qt_giphy_test_preet/Constants/ConstantWidgets.dart';
import 'package:qt_giphy_test_preet/Screens/Login/LoginController.dart';
import 'package:qt_giphy_test_preet/Screens/Signup/SignupScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: Get.height * 0.45,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: AppTheme.primarySwatch,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(200),
                          bottomRight: Radius.circular(40),
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.0),
                        Hero(
                          tag: "iconHero",
                          child: Image.asset(
                            "assets/app_icon_yellow.png",
                            height: 65,
                            width: 65,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20.0),
                        ConstantWidgets.customTextFormField(
                            controller: controller.emailController,
                            labelText: "Email"),
                        SizedBox(height: 20.0),
                        ConstantWidgets.customTextFormField(
                            controller: controller.passwordController,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: controller
                                  .togglePasswordVisibility, // Toggle the password visibility
                            ),
                            obscureText: controller.isObscured,
                            labelText: "Password"),
                        SizedBox(height: 32.0),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppTheme.primarySwatch)),
                                onPressed: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  controller.validateLogin(context);
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'By Logging In, you agree to our Terms & Privacy Policy',
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: '',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '''Don't have an account?''',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: ' Sign Up!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.lightBlueAccent),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                        Get.to(() => SignupScreen(),
                                            transition: Transition.downToUp);
                                      }),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
