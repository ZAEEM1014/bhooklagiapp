import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/theme/app_colors.dart';
import 'controller/nav_bar_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  final BottomNavController controller = Get.find();

  final List<Map<String, dynamic>> _navItems = const [
    {'icon': Icons.restaurant_menu, 'label': 'Food'},
    {'icon': Icons.storefront, 'label': 'Grocery'},
    {'icon': Icons.search, 'label': 'Search'},
    {'icon': Icons.person_outline, 'label': 'Account'},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: kBottomNavigationBarHeight + 10,
        child: Material(
          color: AppColors.white,
          elevation: 8,
          child: Row(
            children: List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              final isSelected = controller.selectedIndex.value == index;

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => controller.changeTab(index),
                    splashColor: AppColors.primary.withOpacity(0.15),
                    highlightColor: AppColors.primary.withOpacity(0.08),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: SizedBox.expand(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item['icon'],
                              color: isSelected ? AppColors.primary : AppColors.border,
                              size: 26,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['label'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected ? AppColors.primary : AppColors.border,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
