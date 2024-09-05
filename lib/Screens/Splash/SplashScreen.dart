import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qt_giphy_test_preet/Screens/Splash/SplashController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (context) {
        return Stack(
          children: [
            Container(
              child: Image.asset(
                'assets/app_bg.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                    
                    tag: "iconHero",
                    child: Image.asset("assets/app_icon_yellow.png", width: Get.width*0.4)),

                SizedBox(height: 26,width: Get.width,),

                Text("Giphy", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),)
              ],
            )
          ],
        );
      }
    );
  }
}
