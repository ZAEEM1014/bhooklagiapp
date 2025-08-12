// lib/app/controller/nav_bar_controller.dart

import 'package:bhooklagiapp/app/modules/Account/view/profile_screen.dart';
import 'package:bhooklagiapp/app/modules/home/view/home_screen.dart';
import 'package:bhooklagiapp/app/modules/search/view/search_screen.dart';
import 'package:get/get.dart';

import '../../app/modules/grocery/view/grosery_screen.dart';



class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = [
    HomeScreen(),
    GroceryScreen(),
    SearchScreen(),
    ProfileScreen(),

  ];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}


