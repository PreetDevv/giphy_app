import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:qt_giphy_test_preet/Constants/ConstantFunctions.dart';
import 'package:qt_giphy_test_preet/Support/Progressbar.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    Progressbar.showProgressbar();

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Progressbar.dismissProgressbar();

      return credential.user;
    } on FirebaseAuthException catch (e) {
      Progressbar.dismissProgressbar();

      if (e.code == 'email-already-in-use') {
        ConstantFunction.getSnakeBar(
            context: context,
            message: 'The email address is already in use.',
            isSuccess: false);
      } else {
        ConstantFunction.getSnakeBar(
            context: context,
            message: 'An error occurred: ${e.code}',
            isSuccess: false);
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    Progressbar.showProgressbar();

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      Progressbar.dismissProgressbar();

      return credential.user;
    } on FirebaseAuthException catch (e) {
      Progressbar.dismissProgressbar();

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ConstantFunction.getSnakeBar(
            context: context,
            message: 'Invalid email or password.',
            isSuccess: false);
      } else {
        ConstantFunction.getSnakeBar(
            context: context,
            message: 'An error occurred: ${e.code}',
            isSuccess: false);
      }
    }
    return null;
  }
}
