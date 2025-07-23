// lib/app/modules/main_wrapper/views/main_wrapper.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/controller/nav_bar_controller.dart';
import '../../../../widgets/custom_navBar.dart';



class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  final BottomNavController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      );
    });
  }
}
