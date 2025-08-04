// File: lib/bindings/location_permission_binding.dart

import 'package:get/get.dart';

import '../modules/location/controller/location_permission_controller.dart';

class LocationPermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationPermissionController>(
            () => LocationPermissionController());
  }
}
