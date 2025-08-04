import 'package:bhooklagiapp/app/modules/checkout/controller/payment_method%20_controller.dart';
import 'package:flutter/material.dart';
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

  // Payment method controller (safe initialization)
  late final PaymentMethodController paymentMethodController;

  @override
  void onInit() {
    // Safely register or find the PaymentMethodController
    if (!Get.isRegistered<PaymentMethodController>()) {
      Get.put(PaymentMethodController());
    }
    paymentMethodController = Get.find<PaymentMethodController>();

    super.onInit();
  }

  // Getters
  double get deliveryFee => _deliveryFee.value;
  double get platformFee => _platformFee.value;
  double get discount => subtotal.value * 0.10;

  double get originalTotal => subtotal.value + deliveryFee + platformFee;
  double get total => originalTotal;

  // Actions
  void selectDeliveryOption(String option) {
    selectedDelivery.value = option;
    _deliveryFee.value =
    (option == 'Priority') ? _baseDeliveryFee + _priorityExtraFee : _baseDeliveryFee;
  }

  void toggleTopUpWallet(bool value) => topUpWallet.value = value;
  void toggleLeaveAtDoor(bool value) => leaveAtDoor.value = value;

  void selectPaymentMethod() {
    openPaymentMethodSelector(Get.context!);
  }

  void openPaymentMethodSelector(BuildContext context) {
    showPaymentMethodSheet(context);
  }

  void placeOrder() {
    if (paymentMethodController.selectedMethod.value == PaymentType.none) {
      Get.snackbar("Payment Required", "Please select a payment method before placing the order");
      return;
    }

    // Simulate placing an order
    print('--- Order Summary ---');
    print('Subtotal: $subtotal');
    print('Delivery Fee: $deliveryFee');
    print('Platform Fee: $platformFee');
    print('Payment Method: ${paymentMethodController.selectedMethod.value}');
    print('Payment Detail: ${paymentMethodController.selectedDetails.value}');
  }
}
