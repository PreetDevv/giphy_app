import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:qt_giphy_test_preet/Screens/Dashboard/DashboardScreen.dart';
import 'package:qt_giphy_test_preet/Screens/Login/LoginScreen.dart';
import 'package:qt_giphy_test_preet/Support/SharedPreferenceHelper.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Future.delayed(
      Duration(seconds: 3),
      () {
        processSplash();
      },
    );
  }

  void processSplash() {
    SharedPreferenceHelper.instance.getLoginModel().then((value) {
      if (value == null) {
        Get.offAll(() => LoginScreen());
      } else {
        Get.offAll(() => DashboardScreen());
      }
    });
  }
}
