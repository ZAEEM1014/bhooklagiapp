// lib/app/routes/app_pages.dart
import 'package:bhooklagiapp/app/modules/auth/views/email_login_screen.dart';
import 'package:bhooklagiapp/app/modules/auth/views/email_password_screen.dart';
import 'package:bhooklagiapp/app/modules/auth/views/mobile_verification_screen.dart';
import 'package:get/get.dart';

import '../bindings/auth_binding.dart';
import '../bindings/navbar_binding.dart';
import '../modules/auth/controllers/auth_controller.dart';
import '../modules/auth/views/code_verification_screen.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/auth/views/reset_password_screen.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/view/home_screen.dart';
import '../modules/main_wrappeer/view/main_wrapper.dart';
import '../modules/splash/splash_bindings.dart';
import '../modules/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.mainwrapper,
      page: () => MainWrapper(),
      binding: MainWrapperBinding(), // ✅ register controller here
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),

    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
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

    GetPage(
      name: AppRoutes.resetpassword,
      page: () => ResetPasswordScreen(),
      binding:ResetPasswordBinding(),
    ),
  ];
}
