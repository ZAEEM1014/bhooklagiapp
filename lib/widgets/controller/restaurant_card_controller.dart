import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:get/get.dart';

import '../../app/models/restaurant_model.dart';
 // ✅ Adjusted path for consistency

class RestaurantController extends GetxController {
  /// List of available filters
  final filters = <String>[
    "All",
    "Fast Delivery",
    "Top Rated",
    "Free Delivery",
    "Offers",
  ].obs;

  /// List of restaurants
  final restaurants = <Restaurant>[
    Restaurant(
      name: "Spice Hub",
      image: AppAssets.fries,
      rating: 4.3,
      reviews: 120,
      category: "Biryani, Curry",
      deliveryTime: "30 mins",
      offer: "20% OFF",
      isAd: true,
      freeDelivery: true,
    ),
    Restaurant(
      name: "Burger Fix",
      image: AppAssets.burger,
      rating: 4.6,
      reviews: 95,
      category: "Burgers, Fast Food",
      deliveryTime: "25 mins",
      offer: "Free Drink",
      isAd: false,
      freeDelivery: false,
    ),
    Restaurant(
      name: "Pizza Mania",
      image: AppAssets.pizza, // 🔄 Recommend using AppAssets.pizza for consistency
      rating: 4.2,
      reviews: 150,
      category: "Pizza, Italian",
      deliveryTime: "40 mins",
      offer: "Buy 1 Get 1 Free",
      isAd: true,
      freeDelivery: true,
    ),
  ].obs;
}
