import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final showLoginSheet = false.obs;
  final showLogo = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Show login sheet first
    Future.delayed(const Duration(milliseconds: 300), () {
      showLoginSheet.value = true;

      // Then show logo slightly after
      Future.delayed(const Duration(milliseconds: 400), () {
        showLogo.value = true;
      });
    });
  }

  void closeLogin() => Get.back();


  void loginWithGoogle() {
    // TODO: Add actual Google login logic


    Get.toNamed(AppRoutes.mobileverification);
  }


  void loginWithFacebook() {
    // TODO: Add actual Facebook login logic
    Get.snackbar("Facebook Login", "Facebook login clicked");
  }

  void loginWithEmail() {
    // TODO: Navigate to email login screen or show a dialog
    Get.snackbar("Email Login", "Email login clicked");
  }


}
