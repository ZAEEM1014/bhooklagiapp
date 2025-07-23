// lib/app/modules/main_wrapper/bindings/main_wrapper_binding.dart

import 'package:get/get.dart';

import '../../widgets/controller/nav_bar_controller.dart';



class MainWrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());
  }
}
