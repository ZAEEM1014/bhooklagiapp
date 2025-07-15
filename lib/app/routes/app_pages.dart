// lib/app/routes/app_pages.dart
import 'package:bhooklagiapp/app/modules/auth/views/mobile_verification_screen.dart';
import 'package:get/get.dart';

import '../modules/auth/bindings/login_bindings.dart';
import '../modules/auth/bindings/mobile_verification_bindings.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/splash/splash_bindings.dart';
import '../modules/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.mobileverification,
      page: () => MobileVerificationScreen(),
      binding: MobileVerificationBinding(),
    ),
  ];
}
