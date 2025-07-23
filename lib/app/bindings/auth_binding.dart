import 'package:bhooklagiapp/app/modules/auth/controllers/email_password_controller.dart';
import 'package:bhooklagiapp/app/modules/auth/controllers/emial_login_controller.dart';
import 'package:get/get.dart';
import '../modules/auth/controllers/code_verification_controller.dart';
import '../modules/auth/controllers/login_controller.dart';
import '../modules/auth/controllers/mobile_verification_controller.dart';
import '../modules/auth/controllers/reset_password_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class MobileVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MobileVerificationController());
  }
}

class CodeVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CodeVerificationController());
  }
}

class EmailloginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailLoginController>(() => EmailLoginController());
  }
}

class EmailPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailPasswordController>(() => EmailPasswordController());
  }
}

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}