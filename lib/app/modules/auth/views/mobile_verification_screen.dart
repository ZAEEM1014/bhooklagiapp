import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:bhooklagiapp/app/theme/theme.dart';
import '../../../../widgets/app_button.dart';
import '../../../theme/app_colors.dart';
import '../controllers/mobile_verification_controller.dart';

class MobileVerificationScreen extends StatelessWidget {
  final controller = Get.put(MobileVerificationController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
            onPressed: () => Get.back(),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Stack(
            children: [
              /// Main Scrollable Content
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          const SizedBox(height: 40),

                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                AppAssets.mobileVarLogo,
                                width: 160,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Center(
                            child: Text(
                              "What's your mobile number?",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Center(
                            child: const Text(
                              "We need this to verify and secure your account",
                              style: TextStyle(color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Obx(() => Row(
                            children: [
                              GestureDetector(
                                onTap: controller.pickCountryCode,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.border),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(controller.selectedCountryCode.value),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: controller.onPhoneChanged,
                                  decoration: InputDecoration(
                                    hintText: 'Mobile number',
                                    filled: true,
                                    fillColor: AppColors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),

                          const SizedBox(height: 100), // Leave space for bottom button
                        ],
                      ),
                    ),
                  );
                },
              ),

              /// Bottom Button (Sticky + Shadowed)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Obx(() {
                  final isEnabled = controller.isPhoneValid;
                  return SafeArea(
                    top: false,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        text: "Continue",
                        onPressed: isEnabled ? controller.verifyPhoneNumber : null,
                        isEnabled: isEnabled,
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
