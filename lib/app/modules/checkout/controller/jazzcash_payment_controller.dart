import 'package:bhooklagiapp/app/modules/checkout/controller/payment_method%20_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JazzCashPaymentController extends GetxController {
  final mobileController = TextEditingController();
  final cnicController = TextEditingController();
  var isButtonEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    mobileController.addListener(_validateFields);
    cnicController.addListener(_validateFields);
  }

  void _validateFields() {
    final isMobileValid = mobileController.text.trim().length == 11;
    final isCnicValid = cnicController.text.trim().length == 6;
    isButtonEnabled.value = isMobileValid && isCnicValid;
  }

  void submitPayment() {
    final paymentMethodController = Get.find<PaymentMethodController>();

    // Store selected method and detail
    paymentMethodController.setMethod(
      PaymentType.jazzCash,
      "JazzCash Account", // Or include number if needed
    );

    // Navigate back to Checkout screen
    Get.back(); // If only popping sheet
    // Or use: Get.until((route) => route.settings.name == '/checkout');

    // Optional: Show confirmation
    Get.snackbar("Payment Method", "JazzCash selected");
  }






  @override
  void onClose() {
    mobileController.dispose();
    cnicController.dispose();
    super.onClose();
  }
}
