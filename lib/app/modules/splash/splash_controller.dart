import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // User is already signed in → go to home or verification screen
        Get.offAllNamed(AppRoutes.mobileverification);
      } else {
        // Not signed in → go to login screen
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }
}
