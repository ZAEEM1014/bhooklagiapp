import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:bhooklagiapp/app/theme/theme.dart';
import '../controllers/login_controller.dart';
import '../widgets/custom_outlined_icon_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(LoginController());
  final double loginSheetHeight = 400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // 🔴 Logo shows later and centered
          Stack(
            children: [
              //  Animated Login Container (already done)

              // ✅ Move Logo Up using Positioned
              Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                top: controller.showLogo.value ? 120 : 200, // 🔧 Adjust this value
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: controller.showLogo.value ? 1 : 0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn,
                  child: Center(
                    child: Image.asset(
                      'assets/logos/logo.png',
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              )),

              // ✅ Close button
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: controller.closeLogin,
                  child: const Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            ],
          ),


          // ⬆️ Login sheet slides up first
          Obx(() => AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            left: 0,
            right: 0,

            bottom: controller.showLoginSheet.value ? 0 : -loginSheetHeight,
            height: 360,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Sign up or Log in',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Select your preferred method to continue',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 16),

                    CustomButton(
                      icon: SvgPicture.asset('assets/icons/google.svg', height: 24),
                      label: 'Continue with Google',
                      textColor: AppColors.hintText,
                      bgColor: Colors.white,
                      borderColor: AppColors.border,
                      borderWidth: 1.2,
                      onTap: controller.loginWithGoogle,
                    ),
                    const SizedBox(height: 13),

                    CustomButton(
                      icon: const Icon(Icons.facebook, color: Colors.white),
                      label: 'Continue with Facebook',
                      textColor: Colors.white,
                      bgColor: AppColors.primary,
                      borderColor:  AppColors.primary,
                      borderWidth: 0,
                      onTap: controller.loginWithFacebook,
                    ),
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Expanded(child: Divider(thickness: 1, color: AppColors.border)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('or', style: TextStyle(color: AppColors.border)),
                        ),
                        Expanded(child: Divider(thickness: 1, color: AppColors.border)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      icon: const Icon(Icons.mail_outline, color: AppColors.primary),
                      label: 'Continue with email',
                      textColor: AppColors.primary,
                      bgColor: Colors.white,
                      borderColor: AppColors.primary,
                      borderWidth: 1.2,
                      onTap: controller.loginWithEmail,
                    ),
                    const SizedBox(height: 16),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'By continuing, you agree to our ', style: TextStyle(fontSize: 12)),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(text: ' and ', style: TextStyle(fontSize: 12)),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
