import 'dart:async';

import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qt_giphy_test_preet/Models/FavModel.dart';
import 'package:qt_giphy_test_preet/Models/GifModel.dart';
import 'package:qt_giphy_test_preet/Models/LoginModel.dart';
import 'package:qt_giphy_test_preet/Support/Progressbar.dart';
import 'package:qt_giphy_test_preet/Support/SharedPreferenceHelper.dart';

import '../../Constants/AppTheme.dart';
import '../../Constants/ConstantWidgets.dart';
import '../../Support/ApiService.dart';

class DashboardController extends GetxController {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<GifModel> gifModelList = [];

  List<FavModel> favoritesList = [];

  LoginModel? loginModel;

  bool isDataLoading = true;

  bool isAPIHitting = false; // for bottom sheet

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    SharedPreferenceHelper.instance.getLoginModel().then((value) {
      loginModel = value;

      getTrendingGifs(gifModelList.length);
      scrollController.addListener(scrollListener);
      getAllFavorites();
    });
  }

  void getAllFavorites() async {
    // Reference to the Favs collection
    final collectionRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(loginModel!.userID.toString())
        .collection("Favs");

    // Get all documents from the collection
    QuerySnapshot querySnapshot = await collectionRef.get();

    isDataLoading = false;

    // Convert each document to a FavModel
    favoritesList = querySnapshot.docs.map((doc) {
      return FavModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    update();
  }

  void scrollListener() {
    // If at the end of the scroll
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("lfsdgkgnlk;fd");
      if (searchController.text.isEmpty) {
        getTrendingGifs(gifModelList.length);
      } else {
        // fetct gif with searched text

        getSearchedGifs(searchController.text, gifModelList.length);
      }
    }
  }

  Future<void> getTrendingGifs(int offset) async {
    isAPIHitting = true;
    final result =
        await ApiService.fetchTrendingGifs(limit: 10, offset: offset);

    isAPIHitting = false;
    if (result != null) {
      result['data'].forEach((element) {
        gifModelList!.add(GifModel.fromJson(element));
      });

      update();
    }
  }

  Future<void> getSearchedGifs(String text, int offset,
      {bool newKeyword = false}) async {
    isAPIHitting = true;
    update();
    final result =
        await ApiService.fetchGifs(limit: 10, offset: offset, query: text);

    isAPIHitting = false;
    update();
    if (result != null) {
      if (newKeyword) {
        gifModelList.clear();
      }
      result['data'].forEach((element) {
        gifModelList!.add(GifModel.fromJson(element));
      });
      update();
    } else {}
  }

  void onTextChanged(String text) {
    gifModelList.clear();
    update();

    if (text.isEmpty) {
      getTrendingGifs(gifModelList.length);
    } else {
      getSearchedGifs(text, gifModelList.length, newKeyword: true);
    }
  }

  void showFullScreenBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes the bottom sheet full-screen
      builder: (context) {
        return GetBuilder(
            init: Get.find<DashboardController>(),
            builder: (controller) {
              return Container(
                height: MediaQuery.of(context).size.height *
                    0.9, // Adjusts the height
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10),
                      child: ConstantWidgets.customTextFormField(
                        controller: searchController,
                        border: OutlineInputBorder(),
                        onTextChange: onTextChanged,
                        onTap: () {
                          print("TextFormField tapped");
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        hintText: "Search Gifs here!",
                      ),
                    ),
                    if (searchController.text.isEmpty &&
                        controller.gifModelList.isNotEmpty)
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Trending🔥",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          )),
                    if (!isAPIHitting)
                      Visibility(
                        visible: controller.gifModelList.isNotEmpty,
                        replacement: Column(
                          children: [
                            SizedBox(
                              height: 120,
                            ),
                            Text(
                              "No records found for the text you entered or the API hitting limit has been exceeded",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        child: Expanded(
                          child: GridView.builder(
                            controller: scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: gifModelList!.length,
                            // Assume gifList is available
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 6),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: gifModelList![index]
                                            .images!
                                            .fixedHeightDownsampled!
                                            .url
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
                                              FavModel(
                                                  gifUrl: gifModelList![index]
                                                      .images!
                                                      .original!
                                                      .url
                                                      .toString(),
                                                  gifId:
                                                      gifModelList![index].id),
                                              loginModel!.userID.toString());
                                        },
                                        icon: checkGifFavs(gifModelList![index]
                                                .id
                                                .toString())
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(Icons.favorite_border)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              );
            });
      },
    );
  }

  bool checkGifFavs(String id) {
    bool exists = false;

    favoritesList.forEach((element) {
      if (element.gifId == id) {
        exists = true;
      }
    });

    return exists;
  }

  void addRemoveFavorites(
    FavModel favModel,
    String userId,
  ) async {
    Progressbar.showProgressbar();
    // Reference to the specific collection where favs are stored
    final collectionRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection("Favs");

    // Query to check if the gifId exists
    QuerySnapshot querySnapshot =
        await collectionRef.where("gifId", isEqualTo: favModel.gifId).get();

    if (querySnapshot.docs.isNotEmpty) {
      // If the document exists, delete it
      await querySnapshot.docs.first.reference.delete();

      favoritesList.removeWhere((element) => element.gifId == favModel.gifId);

      Progressbar.dismissProgressbar();

      update();
      print('Document removed');
    } else {
      // If the document does not exist, add a new document
      await collectionRef.add(favModel.toJson());

      favoritesList.add(favModel);
      Progressbar.dismissProgressbar();

      update();
      print('Document added');
    }
  }
}
