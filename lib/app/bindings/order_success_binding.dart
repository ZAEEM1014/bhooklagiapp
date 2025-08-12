import 'package:get/get.dart';

import '../modules/checkout/controller/order_success_controller.dart';

class OrderSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderSuccessController>(() => OrderSuccessController());
  }
}
