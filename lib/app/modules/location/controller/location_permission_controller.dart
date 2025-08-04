// File: controllers/location_permission_controller.dart

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';


class LocationPermissionController extends GetxController {
  var hasSeenLocationIntro = false.obs;

  Future<void> checkIfSeen() async {
    final prefs = await SharedPreferences.getInstance();
    hasSeenLocationIntro.value = prefs.getBool('seenLocationIntro') ?? false;
  }

  Future<void> markAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenLocationIntro', true);
  }

  Future<void> continueToLocationSelection() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenLocationIntro', true);

    Get.offAllNamed(AppRoutes.mainwrapper);
  }

}
