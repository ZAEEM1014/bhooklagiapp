import 'package:bhooklagiapp/app/modules/checkout/controller/payment_method%20_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardController extends GetxController {
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();
  final nameController = TextEditingController();

  var saveCard = true.obs;
  var isFormFilled = false.obs;

  void checkFormValidity() {
    isFormFilled.value = cardNumberController.text.isNotEmpty &&
        expiryController.text.isNotEmpty &&
        cvcController.text.isNotEmpty &&
        nameController.text.isNotEmpty;
  }

  void submitCard() {
    final paymentMethodController = Get.find<PaymentMethodController>();

    // Store selected card in checkout state
    final last4Digits = cardNumberController.text.trim();
    String displayCard =
    last4Digits.length >= 4 ? "Visa **** ${last4Digits.substring(last4Digits.length - 4)}" : "Credit Card";

    paymentMethodController.setMethod(
      PaymentType.creditCard,
      displayCard,
    );

    // Navigate back to checkout screen
    Get.back();

    // Optional feedback
    Get.snackbar("Payment Method", "$displayCard selected");
  }

  @override
  void onInit() {
    cardNumberController.addListener(checkFormValidity);
    expiryController.addListener(checkFormValidity);
    cvcController.addListener(checkFormValidity);
    nameController.addListener(checkFormValidity);
    super.onInit();
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
