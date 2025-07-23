// lib/app/modules/home/views/unavailable_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_navBar.dart';
import '../../../../widgets/home_sliver_appbar.dart';
import '../../../theme/app_colors.dart';
import '../../home/controllers/home_controller.dart';

class GroceryScreen extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          HomeSliverAppBar(controller: controller),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Position image
                Positioned(
                  top: 105,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/logos/unavailable.png',
                    height: 250,
                    width: 170,
                    fit: BoxFit.contain,
                  ),
                ),

                // Position text separately
                Positioned(
                  top: 370, // Adjust based on your image height
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Text(
                        "We’re currently not available in your area",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          height: 1.1,
                          fontSize: 30,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "We’re working on it! Check back later.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          fontSize: 16,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
