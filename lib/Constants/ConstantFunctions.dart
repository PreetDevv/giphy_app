import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConstantFunction{






  static void getSnakeBar({
    required BuildContext context,
    required String message,
    required bool isSuccess,
    Duration duration = const Duration(seconds: 2),
  }) {
    final Color backgroundColor = isSuccess ? Colors.green : Colors.red;

    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
        left: 16.0,
        right: 16.0,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



}