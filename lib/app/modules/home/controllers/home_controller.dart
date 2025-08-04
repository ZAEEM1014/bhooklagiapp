import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/category_model.dart';

class HomeController extends GetxController {
  var location = '15 A Chenab Gate Road'.obs;
  var showIntro = true.obs;
  var showSearchBar = true.obs;

  /// 👇 This is used by each RestaurantCard to know current scroll position
  final RxDouble scrollOffset = 0.0.obs;

  final ScrollController scrollController = ScrollController();

  final double scrollThresholdForIntro = 100;
  final double scrollThresholdForSearch = 160;

  final List<TopOption> topOptions = [
    TopOption(assetPath: AppAssets.offers, label: 'Offers'),
    TopOption(assetPath: AppAssets.pickup, label: 'Pick-up'),
    TopOption(assetPath: AppAssets.homechief, label: 'Homechiefs'),
    TopOption(assetPath: AppAssets.newrestaurant, label: 'Restaurants'),
  ];

  final List<CategoryModel> categories = [
    CategoryModel(name: 'Pizza', imagePath: AppAssets.pizza),
    CategoryModel(name: 'Biryani', imagePath: AppAssets.biryani),
    CategoryModel(name: 'Burgers', imagePath: AppAssets.burger),
    CategoryModel(name: 'Paratha', imagePath: AppAssets.paratha),
    CategoryModel(name: 'Icecream', imagePath: AppAssets.iceCream),
    CategoryModel(name: 'Fries', imagePath: AppAssets.fries),
    CategoryModel(name: 'Desert', imagePath: AppAssets.desert),
    CategoryModel(name: 'Shakes', imagePath: AppAssets.shakes),
    CategoryModel(name: 'Samosa', imagePath: AppAssets.samosa),
  ];

  final RxList<String> filters = ['Sort', 'Pro Benefits', 'Offers', 'Rating 4.0+'].obs;

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  void _scrollListener() {
    final offset = scrollController.offset;

    /// ✅ This is critical for card fade animation logic
    scrollOffset.value = offset;

    if (offset > scrollThresholdForIntro && showIntro.value) {
      showIntro.value = false;
    } else if (offset <= scrollThresholdForIntro && !showIntro.value) {
      showIntro.value = true;
    }

    if (offset > scrollThresholdForSearch && showSearchBar.value) {
      showSearchBar.value = false;
    } else if (offset <= scrollThresholdForSearch && !showSearchBar.value) {
      showSearchBar.value = true;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class TopOption {
  final String assetPath;
  final String label;

  TopOption({required this.assetPath, required this.label});
}
