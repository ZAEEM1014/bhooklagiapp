import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme.dart';
import '../views/reset_password_screen.dart';

class ResetPasswordController extends GetxController {

  var isPasswordVisible = false.obs;
  var password = ''.obs;

  var hasMinLength = false.obs;
  var hasUppercase = false.obs;
  var hasLowercase = false.obs;
  var hasNumber = false.obs;
  var passwordStrengthLabel = "Very Weak".obs;


  var passwordStrength = 0.0.obs;
  var isPasswordValid = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void onPasswordChanged(String value) {
    password.value = value;

    hasMinLength.value = value.length >= 8;
    hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
    hasLowercase.value = value.contains(RegExp(r'[a-z]'));
    hasNumber.value = value.contains(RegExp(r'[0-9]'));

    double strength = 0;
    if (hasMinLength.value) strength += 0.25;
    if (hasUppercase.value) strength += 0.25;
    if (hasLowercase.value) strength += 0.25;
    if (hasNumber.value) strength += 0.25;
    passwordStrength.value = strength;

    // Update label
    if (strength < 0.25) {
      passwordStrengthLabel.value = "Very Weak";
    } else if (strength < 0.5) {
      passwordStrengthLabel.value = "Weak";
    } else if (strength < 0.75) {
      passwordStrengthLabel.value = "Moderate";
    } else {
      passwordStrengthLabel.value = "Strong";
    }

    isPasswordValid.value = strength == 1.0;
  }


  Color getStrengthColor() {
    if (passwordStrength.value < 0.4) return AppColors.red;
    if (passwordStrength.value < 0.7) return AppColors.orange;
    return AppColors.green;
  }

  void resetPassword() {
    Get.bottomSheet(
      ResetSuccessSheet(onClose: () => Get.back()), // go back to login screen maybe
      isScrollControlled: true,
    );
  }

  void loginWithEmail() {
    Get.toNamed(AppRoutes.emaillogin);
    // TODO: Navigate to email login screen or show a dialog

  }

}
