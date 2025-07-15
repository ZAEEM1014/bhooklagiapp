import 'package:bhooklagiapp/app/modules/auth/controllers/mobile_verification_controller.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';


class MobileVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MobileVerificationController());
  }
}
