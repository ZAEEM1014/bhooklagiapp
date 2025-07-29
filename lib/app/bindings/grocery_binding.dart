// lib/app/modules/grocery/bindings/grocery_binding.dart
import 'package:get/get.dart';
import '../modules/grocery/controller/grocrey_controller.dart';

class GroceryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroceryController>(() => GroceryController());
  }
}
