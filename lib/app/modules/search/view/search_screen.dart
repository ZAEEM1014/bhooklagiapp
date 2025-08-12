

import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';

import '../../../../widgets/custom_text_field.dart';
import '../../../theme/app_colors.dart';

import '../controller/search_controller.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchController controller = Get.put(SearchController());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                hintText: 'Search for restaurants and groceries',
                keyboardType: TextInputType.text,
                onChanged: controller.updateSearchText,
              ),
              const SizedBox(height: 24),
              const Text(
                "Popular searches in Restaurants",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.restaurantSearches
                    .map((item) => Chip(
                  label: Text(item),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ))
                    .toList(),
              )),
              const SizedBox(height: 24),
              const Text(
                "Popular searches in Shops",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.shopSearches
                    .map((item) => Chip(
                  label: Text(item),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ))
                    .toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
