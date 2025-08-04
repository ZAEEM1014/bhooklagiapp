import 'package:get/get.dart';
import '../modules/checkout/controller/payment_method _controller.dart';


class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentMethodController());
  }
}
