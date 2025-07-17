// lib/app/routes/app_pages.dart
import 'package:bhooklagiapp/app/modules/auth/views/email_login_screen.dart';
import 'package:bhooklagiapp/app/modules/auth/views/email_password_screen.dart';
import 'package:bhooklagiapp/app/modules/auth/views/mobile_verification_screen.dart';
import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/code_verification_screen.dart';
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

    GetPage(
      name: AppRoutes.codeverification,
      page: () => CodeVerificationScreen(),
      binding:CodeVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.emaillogin,
      page: () => EmailLoginScreen(),
      binding:EmailloginBinding(),
    ),

    GetPage(
      name: AppRoutes.emailpassword,
      page: () => EmailPasswordScreen(),
      binding:EmailPasswordBinding(),
    ),
  ];
}
