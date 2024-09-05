import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../Constants/AppTheme.dart';



class Progressbar {
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60.0
      ..radius = 40.0
      ..progressColor = AppTheme.primarySwatch
      ..backgroundColor = Colors.transparent
      ..indicatorColor = AppTheme.primarySwatch
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = [];
    // ..customAnimation = CustomAnimation();
  }

  static showProgressbar() {
    EasyLoading.show();
  }

  static dismissProgressbar() {
    EasyLoading.dismiss();
  }
}
