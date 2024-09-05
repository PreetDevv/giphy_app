import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qt_giphy_test_preet/Screens/Splash/SplashScreen.dart';
import 'package:qt_giphy_test_preet/Support/SharedPreferenceHelper.dart';


class LogoutConfirmationDialog extends StatefulWidget {
  @override
  _LogoutConfirmationDialogState createState() => _LogoutConfirmationDialogState();
}

class _LogoutConfirmationDialogState extends State<LogoutConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 250.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.warning,
              size: 40.0,
              color: Colors.orange,
            ),
            SizedBox(height: 10.0),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Lato',
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Call logout function here
                    Get.back();
                    await SharedPreferenceHelper.instance.clear();

                    Get.offAll(() => SplashScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[600],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}