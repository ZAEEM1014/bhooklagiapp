import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bhooklagiapp/app/theme/theme.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../views/email_password_screen.dart';

class EmailPasswordController extends GetxController {
  late final String email;

  final password = ''.obs;
  final isPasswordVisible = false.obs;
  final isPasswordValid = false.obs;

  @override
  void onInit() {
    super.onInit();
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

    Get.toNamed(AppRoutes.mainwrapper, );
  }

  void forgotPasswordFlow() {
    Get.bottomSheet(
      ForgotPasswordSheet(
        email: email,
        onResetSuccess: showSuccessBottomSheet,
      ),
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void showSuccessBottomSheet() {
    Future.delayed(const Duration(milliseconds: 300), () {
      Get.back(); // Close forgot password sheet
      Get.bottomSheet(
        SuccessBottomSheet(onResetSuccess: Get.back),
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      );
    });
  }

}
