import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qt_giphy_test_preet/Constants/ConstantString.dart';
import 'package:qt_giphy_test_preet/Models/LoginModel.dart';
import 'package:qt_giphy_test_preet/Screens/Dashboard/DashboardScreen.dart';
import 'package:qt_giphy_test_preet/Support/SharedPreferenceHelper.dart';

import '../../Constants/ConstantFunctions.dart';
import '../../Support/FirebaseAuthService.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscured = true;

  validateLogin(BuildContext context) {
    if (emailController.text.isEmpty) {
      ConstantFunction.getSnakeBar(
          context: context, message: "Please enter email.", isSuccess: false);
      return;
    } else if (!GetUtils.isEmail(emailController.text)) {
      ConstantFunction.getSnakeBar(
          context: context,
          message: "Please enter a valid email.",
          isSuccess: false);
      return;
    } else if (passwordController.text.isEmpty) {
      ConstantFunction.getSnakeBar(
          context: context,
          message: "Please enter password.",
          isSuccess: false);
      return;
    }

    login(context);
  }

  void togglePasswordVisibility() {
    isObscured = !isObscured;
    update();
  }

  Future<void> login(BuildContext context) async {
    User? user = await FirebaseAuthService().signInWithEmailAndPassword(
        context, emailController.text, passwordController.text);

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user!.uid)
              .get();

      print(documentSnapshot.data());

      await SharedPreferenceHelper.instance.setString(
          ConstantString.USER_LOGIN, jsonEncode(documentSnapshot.data()));

      ConstantFunction.getSnakeBar(
          context: context, message: "Login Successful!", isSuccess: true);

      Get.offAll(() => DashboardScreen());
    }
  }
}
