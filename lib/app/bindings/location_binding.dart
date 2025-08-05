// lib/modules/location/bindings/location_binding.dart

import 'package:get/get.dart';

import '../modules/location/controller/location-controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
