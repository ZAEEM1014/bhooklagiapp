import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class CheckoutController extends GetxController {
  var subtotal = 1247.99.obs;
  var deliveryFee = 0.0;
  var tax = 0.0;
  var selectedDelivery = 'Standard'.obs;
  var topUpWallet = false.obs;

  double get total => subtotal.value + deliveryFee + tax;

  void selectDeliveryOption(String option) {
    selectedDelivery.value = option;
    deliveryFee = (option == 'Priority') ? 70.0 : 0.0;
    update();
  }

  void toggleTopUpWallet(bool value) {
    topUpWallet.value = value;
  }

  void placeOrder() {

  }
}
