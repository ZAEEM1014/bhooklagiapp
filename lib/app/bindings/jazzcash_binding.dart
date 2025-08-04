import 'package:get/get.dart';
import '../modules/checkout/controller/jazzcash_payment_controller.dart';


class JazzCashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JazzCashPaymentController());
  }
}
