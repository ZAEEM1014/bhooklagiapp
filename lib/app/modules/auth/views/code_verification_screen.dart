import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_button.dart';
import '../../../theme/theme.dart';
import '../controllers/code_verification_controller.dart';

class CodeVerificationScreen extends StatelessWidget {
  final controller = Get.put(CodeVerificationController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              /// Back Button Positioned at Top
              Positioned(
                top: 10,
                left: 0,
                child: SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    onPressed: () {
                      if (Get.previousRoute.isNotEmpty) {
                        Get.back();
                      } else {
                        // Navigate to fallback screen if this is the only screen
                        Get.offAllNamed(
                            '/phone_input'); // Adjust route name as needed
                      }
                    },
                  ),
                ),
              ),

              /// Main Content
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Center(
                              child: Image.asset(
                                AppAssets.mobileVarLogo,
                                width: 150,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                'Verify Your Mobile Number',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Obx(() => Text.rich(
                                TextSpan(
                                  text: 'Enter the verification code we sent you on:\n',
                                  style: const TextStyle(color: AppColors.hintText),
                                  children: [
                                    TextSpan(
                                      text: controller.mobileNumber.value,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              )),

                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(4, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: index < 3 ? 12 : 0),
                                  child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: TextField(
                                      controller:
                                          controller.codeControllers[index],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      style: const TextStyle(fontSize: 24),
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 3) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                        controller.updateCode(index, value);
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Didn't receive code? ",
                                  style: TextStyle(color: AppColors.black),
                                ),
                                TextButton(
                                  onPressed: controller.resendCode,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(0, 0),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    "Resend",
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            Obx(() {
                              return Text(
                                controller.timerText.value,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 16),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              /// Bottom Button with Shadow
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Obx(() {
                  final isComplete = controller.isCodeComplete.value;
                  return SafeArea(
                    top: false,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.border.withOpacity(0.2),
                            blurRadius: 3,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: AppButton(
                        text: "Verify",
                        onPressed: isComplete ? controller.verifyCode : null,
                        isEnabled: isComplete,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
