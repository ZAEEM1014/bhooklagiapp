import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/modules/cart/controller/cart_controller.dart';
import '../app/modules/home/controllers/home_controller.dart';
import '../app/routes/app_routes.dart';
import '../app/theme/app_colors.dart';

class HomeSliverAppBar extends StatelessWidget {
  final HomeController controller;

  const HomeSliverAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return SliverAppBar(
      backgroundColor: AppColors.primary,
      floating: true,
      pinned: true,
      snap: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.white),
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
          icon: const Icon(Icons.favorite_border, color: AppColors.white),
          onPressed: () {
            Get.toNamed(AppRoutes.favorite);
          },
        ),
        Obx(() {
          final count = cartController.totalItems.value;
          return Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.white),
                onPressed: () {
                  Get.toNamed(AppRoutes.cart, arguments: {
                    'restaurantId': cartController.currentRestaurantId ?? '',
                  });

                },
              ),
              if (count > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          );
        }),
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
                fillColor: AppColors.white,
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
