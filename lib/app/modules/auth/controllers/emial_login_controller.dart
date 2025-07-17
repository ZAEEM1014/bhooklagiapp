import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class EmailLoginController extends GetxController {
  final RxString email = ''.obs;
  final RxBool isEmailValid = false.obs;

  void onEmailChanged(String value) {
    email.value = value;
    isEmailValid.value = GetUtils.isEmail(value.trim());
  }

  void verifyEmail() {
    final trimmedEmail = email.value.trim();
    if (GetUtils.isEmail(trimmedEmail)) {
      Get.toNamed(AppRoutes.emailpassword, arguments: trimmedEmail);
      print("Navigating with email: $trimmedEmail");
    }
  }
}
