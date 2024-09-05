import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qt_giphy_test_preet/Constants/AppTheme.dart';
import 'package:qt_giphy_test_preet/Constants/ConstantWidgets.dart';
import 'package:qt_giphy_test_preet/Screens/Login/LoginController.dart';
import 'package:qt_giphy_test_preet/Screens/Signup/SignupController.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignupController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppTheme.primarySwatch,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: AppTheme.primarySwatch,
            ),
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    // color: Colors.white,

                  borderRadius: BorderRadius.circular(24)

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Icon(Icons.arrow_back_outlined, size: 36,),
                    //
                    // SizedBox(height: 20.0),
                    Image.asset(
                      "assets/app_icon_black.png",
                      height: 65,
                      width: 65,
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    ConstantWidgets.customTextFormField(
                        controller: controller.nameController,
                        labelText: "Name"),
                    SizedBox(height: 20.0),
                    ConstantWidgets.customTextFormField(
                        controller: controller.emailController,
                        labelText: "Email"),
                    SizedBox(height: 20.0),
                    ConstantWidgets.customTextFormField(
                        controller: controller.passwordController,
                        suffixIcon:  IconButton(
                          icon: Icon(
                            controller.isObscured ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility, // Toggle the password visibility
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
                                    Colors.black)),
                            onPressed: () {

                              FocusManager.instance.primaryFocus!.unfocus();

                              controller.validateSignup(context);

                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: AppTheme.primarySwatch,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'By Signing up, you agree to our Terms & Privacy Policy',
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
                            TextSpan(text: '''Already have an account?''', style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(text: ' Go Back!',style: TextStyle(fontWeight: FontWeight.w600, color: Colors.lightBlueAccent),recognizer: TapGestureRecognizer()
                              ..onTap = () {

                                Get.back();

                              }),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          );
        });
  }
}
