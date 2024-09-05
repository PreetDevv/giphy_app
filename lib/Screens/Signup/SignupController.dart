import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qt_giphy_test_preet/Constants/ConstantFunctions.dart';
import 'package:qt_giphy_test_preet/Support/FirebaseAuthService.dart';
import 'package:qt_giphy_test_preet/Support/Progressbar.dart';

import '../../Models/LoginModel.dart';

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscured = true;

  void togglePasswordVisibility() {
    isObscured = !isObscured;
    update();
  }

  validateSignup(BuildContext context) {
    if (nameController.text.isEmpty) {
      ConstantFunction.getSnakeBar(
          context: context, message: "Please enter name.", isSuccess: false);

      return;
    } else if (emailController.text.isEmpty) {
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

    signup(context);
  }

  Future<void> signup(BuildContext context) async {
    User? user = await FirebaseAuthService().signUpWithEmailAndPassword(
        context, emailController.text, passwordController.text);

    if (user != null) {
      getAddUserDoc(user, context);
    }
  }

  Future getAddUserDoc(User user, BuildContext context) async {
    Progressbar.showProgressbar();

    LoginModel userModel = LoginModel(
        name: nameController.text,
        userID: user.uid,
        email: emailController.text);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .set(userModel.toJson())
        .onError((error, stackTrace) {
      Progressbar.dismissProgressbar();
      ConstantFunction.getSnakeBar(
          context: context, message: error.toString(), isSuccess: true);
    });

    Progressbar.dismissProgressbar();

    ConstantFunction.getSnakeBar(
        context: context, message: "User has been created!", isSuccess: true);
    Get.back();
  }
}
