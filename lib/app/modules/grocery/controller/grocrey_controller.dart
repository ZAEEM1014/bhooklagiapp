// lib/app/modules/grocery/controllers/grocery_controller.dart
import 'package:get/get.dart';

class GroceryController extends GetxController {
  // Add any logic or observables here if needed
  final RxBool isServiceAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    // You can fetch availability status from API here in future
  }
}
