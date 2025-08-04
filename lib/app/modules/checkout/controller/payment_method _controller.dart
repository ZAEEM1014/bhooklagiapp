import 'package:get/get.dart';

enum PaymentType { none, jazzCash, creditCard,  cash }

class PaymentMethodController extends GetxController {
  final selectedMethod = PaymentType.none.obs;
  final selectedDetails = ''.obs;

  void setMethod(PaymentType method, String details) {
    selectedMethod.value = method;
    selectedDetails.value = details;
  }

  void resetMethod() {
    selectedMethod.value = PaymentType.none;
    selectedDetails.value = '';
  }
}
