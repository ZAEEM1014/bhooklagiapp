import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CodeVerificationController extends GetxController with WidgetsBindingObserver {
  /// Observes keyboard visibility
  final RxBool keyboardVisible = false.obs;

  /// Mobile number received from previous screen
  final RxString mobileNumber = ''.obs;

  /// OTP code input fields
  final List<TextEditingController> codeControllers =
  List.generate(4, (_) => TextEditingController());

  /// Whether the 4-digit code is complete
  final RxBool isCodeComplete = false.obs;

  /// Countdown timer text
  final RxString timerText = '00:30'.obs;

  @override
  void onInit() {
    super.onInit();

    // Observe keyboard visibility
    WidgetsBinding.instance.addObserver(this);

    // Retrieve passed arguments
    final args = Get.arguments;
    if (args != null && args['full'] != null) {
      mobileNumber.value = args['full'];
    }
  }

  /// Called when view insets (keyboard) change
  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    keyboardVisible.value = bottomInset > 0;
  }

  /// Cleanup
  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    for (final controller in codeControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  /// Updates the code and checks completion
  void updateCode(int index, String value) {
    isCodeComplete.value =
        codeControllers.every((controller) => controller.text.isNotEmpty);
  }

  /// Called when "Resend" is tapped
  void resendCode() {
    // Implement resend logic
  }

  /// Called when "Verify" button is pressed
  void verifyCode() {
    // Implement verification logic
  }

  /// Closes the screen (optional helper)
  void closeLogin() {
    Get.back();
  }
}
