import 'package:get/get.dart';
import 'auth_controller.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final showLoginSheet = false.obs;
  final showLogo = false.obs;

  final authController = Get.find<AuthController>(); // ✅ Inject AuthController

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(milliseconds: 300), () {
      showLoginSheet.value = true;
      Future.delayed(const Duration(milliseconds: 400), () {
        showLogo.value = true;
      });
    });
  }

  void closeLogin() => Get.back();

  void loginWithGoogle() async {
    await authController.signInWithGoogle();

    if (authController.user.value != null) {
      Get.toNamed(AppRoutes.mobileverification); // ✅ Redirect if login successful
    }
  }

  void loginWithFacebook() {
    Get.snackbar("Facebook Login", "Facebook login clicked");
  }

  void loginWithEmail() {
    Get.toNamed(AppRoutes.emaillogin);
  }
}
