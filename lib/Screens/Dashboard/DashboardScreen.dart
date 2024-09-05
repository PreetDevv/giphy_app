import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qt_giphy_test_preet/Constants/AppTheme.dart';
import 'package:qt_giphy_test_preet/Constants/ConstantWidgets.dart';
import 'package:qt_giphy_test_preet/Screens/Dashboard/DashboardController.dart';
import 'package:qt_giphy_test_preet/Screens/Login/LoginController.dart';

import '../../Models/FavModel.dart';
import '../../Support/LogoutConfirmationDialog.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppTheme.primarySwatch.shade200,
            appBar: AppBar(
              backgroundColor: AppTheme.primarySwatch.shade200,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: "iconHero",
                    child: Image.asset(
                      "assets/app_icon_yellow.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Dashboard"),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            LogoutConfirmationDialog(),
                      );
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ))
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Container(
                    color: Colors.white,
                    child: ConstantWidgets.customTextFormField(
                        controller: TextEditingController(),
                        border: OutlineInputBorder(),
                        readOnly: true,
                        onTap: () {
                          controller.showFullScreenBottomSheet(context);
                        },
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        hintText: "Search Gifs here!"),
                  ),
                ),
                if (!controller.isDataLoading)
                  Expanded(
                    child: Visibility(
                      visible: controller.favoritesList.isNotEmpty,
                      replacement: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/empty-folder.png",
                            width: Get.width * 0.50,
                          ),
                          Text(
                            "Your favorite is empty yet",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: controller.favoritesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 6),
                              decoration: BoxDecoration(
                                  // border: Border.all(),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Expanded(
                                    child:
                                        // Image.network(controller.favoritesList[index].gifUrl.toString())

                                        CachedNetworkImage(
                                      imageUrl: controller
                                          .favoritesList[index].gifUrl
                                          .toString(),
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                        color: AppTheme.primarySwatch,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      onPressed: () {
                                        controller!.addRemoveFavorites(
                                            controller.favoritesList[index],
                                            controller.loginModel!.userID
                                                .toString());
                                      },
                                      icon: Icon(
                                        Icons.delete_outline_outlined,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
