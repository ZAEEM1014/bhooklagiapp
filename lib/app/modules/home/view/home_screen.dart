import 'package:bhooklagiapp/widgets/custom_navBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_assets.dart';
import '../../../../widgets/controller/restaurant_card_controller.dart';
import '../../../../widgets/home_sliver_appbar.dart';
import '../../../../widgets/restaurat_card.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/scroll_behavior.dart';
import '../../location/controller/location-controller.dart';
import '../../restaurant_deatil/view/restaurant_deatil_screen.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());
  final restaurantController = Get.put(RestaurantController());
  final LocationController locationController = Get.find<LocationController>();


  @override



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: NestedScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            HomeSliverAppBar(controller: controller),
            SliverToBoxAdapter(
              child: Obx(() {
                final offset = controller.scrollOffset.value;
                final fade = (1 - offset / 120).clamp(0.0, 1.0);
                final translate = (offset * 0.4).clamp(0.0, 60.0);

                return Opacity(
                  opacity: fade,
                  child: Transform.translate(
                    offset: Offset(0, translate),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  " Bhook  ",
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    fontSize: 55,
                                    color: AppColors.white,
                                  ),
                                ),
                                Text(
                                  " Lagi Hai ? ",
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    fontSize: 50,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(AppAssets.cartoon, height: 120),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            SliverPersistentHeader(

              pinned: true,
              delegate: _StickyHeaderDelegate(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Filter Bar


                      /// Categories
                      SizedBox(
                        height: 80,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: controller.categories.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 20),
                          itemBuilder: (_, index) {
                            final category = controller.categories[index];
                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child:CachedNetworkImage(
                                    imageUrl: category.imagePath,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,

                                    errorWidget: (context, url, error) => Icon(Icons.broken_image),
                                  )
                                ),
                                const SizedBox(height: 6),
                                Text(category.name),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: AppColors.white,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 0),
            children: [
              Divider(color: AppColors.border.shade400),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Explore Restaurants',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              /// Restaurant Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() => Column(
                  children: restaurantController.restaurants.map((restaurant) {
                    return RestaurantCard(
                      restaurant: restaurant,
                      onTap: () {
                        Get.to(() => RestaurantDetailScreen(restaurant: restaurant));
                      },
                    );
                  }).toList(),
                )),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );

  }

}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 110;
  @override
  double get maxExtent => 110;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

