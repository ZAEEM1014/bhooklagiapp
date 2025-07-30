import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/checkout_screen.dart';

class CheckoutController extends GetxController {
  // Observable values
  final subtotal = 1247.99.obs;
  final selectedDelivery = 'Standard'.obs;
  final topUpWallet = false.obs;
  final leaveAtDoor = false.obs;

  // Delivery fees
  static const double _baseDeliveryFee = 130.0;
  static const double _priorityExtraFee = 70.0;
  final _deliveryFee = RxDouble(_baseDeliveryFee);

  // Platform fee
  final _platformFee = 19.99.obs;

  // Getters
  double get deliveryFee => _deliveryFee.value;
  double get platformFee => _platformFee.value;
  double get discount => subtotal.value * 0.10;

  double get originalTotal => subtotal.value + deliveryFee + platformFee;
  double get total => originalTotal ;

  // Actions
  void selectDeliveryOption(String option) {
    selectedDelivery.value = option;
    _deliveryFee.value = (option == 'Priority')
        ? _baseDeliveryFee + _priorityExtraFee
        : _baseDeliveryFee;
  }

  void toggleTopUpWallet(bool value) => topUpWallet.value = value;

  void toggleLeaveAtDoor(bool value) => leaveAtDoor.value = value;

  void selectPaymentMethod() {
    print('Select payment method pressed');
    // Add your Get.toNamed() logic here
  }

  void openPaymentMethodSelector(BuildContext context) {
    showPaymentMethodSheet(context);
  }

  void placeOrder() {
    print('Place order logic here');
    // Add API/logic to handle order placement
  }
}
