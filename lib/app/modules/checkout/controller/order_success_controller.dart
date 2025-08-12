import 'package:get/get.dart';

class OrderSuccessController extends GetxController {
  var orderId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['orderId'] != null) {
      orderId.value = Get.arguments['orderId'];
    }
  }
}
