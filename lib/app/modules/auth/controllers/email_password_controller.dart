import 'package:get/get.dart';

class EmailPasswordController extends GetxController {
  late final String email;

  final password = ''.obs;
  final isPasswordVisible = false.obs;
  final isPasswordValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the email passed from EmailLoginController
    email = Get.arguments ?? '';
  }

  void onPasswordChanged(String value) {
    password.value = value;
    isPasswordValid.value = value.length >= 6;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void loginWithPassword() {
    if (isPasswordValid.value) {
      print("Logging in with password: ${password.value} for email: $email");
    }
  }

  void sendLoginLink() {
    print("Sending login link to $email...");
  }

  void forgotPassword() {
    print("Forgot password clicked");
  }
}
