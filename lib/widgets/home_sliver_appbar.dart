import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/modules/home/controllers/home_controller.dart';
import '../app/theme/app_colors.dart';

class HomeSliverAppBar extends StatelessWidget {
  final HomeController controller;

  const HomeSliverAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primary,
      floating: true,
      pinned: true,
      snap: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.white),
          const SizedBox(width: 5),
          Obx(() => Text(
            controller.location.value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {
            // TODO: Navigate to favorites screen or handle favorite action
            Get.snackbar("Favorites", "Opening favorites...");
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
          onPressed: () {
            // TODO: Navigate to shopping cart screen
            Get.snackbar("Cart", "Opening shopping bag...");
          },
        ),
        const SizedBox(width: 10),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for restaurants and groceries",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
