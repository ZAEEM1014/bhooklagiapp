import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:bhooklagiapp/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/restaurat_card.dart';
import '../../../theme/app_colors.dart';
import '../../restaurant_deatil/view/restaurant_deatil_screen.dart';
import '../controller/favourite_countroller.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  final controller = Get.find<FavoriteController>(); // Avoid duplicate instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Favourites'),
        centerTitle: true,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.favoriteRestaurants.isEmpty) {
          // Show empty state
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.favorite,
                    width: 180,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Nothing added in Favourites",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Looks like you haven’t added anything to your favourites yet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Show list of favorite restaurants
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.favoriteRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = controller.favoriteRestaurants[index];
              return RestaurantCard(
                restaurant: restaurant,
                onTap: () {
                  Get.to(() => RestaurantDetailScreen(restaurant: restaurant));
                },
              );
            },
          );
        }
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: AppColors.border,
            )
          ],
        ),
        child: AppButton(
          text: "Find Favourites",
          onPressed: controller.goToExplore,
        ),
      ),
    );
  }
}
