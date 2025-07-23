import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:bhooklagiapp/app/theme/theme.dart';
import '../../../../widgets/app_button.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/scroll_behavior.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  final controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(

        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
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
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      reverse: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 100),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),

                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    AppAssets.passwordresetLogo,
                                    width: 160,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Center(
                                child: Text(
                                  "Choose a new password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Center(
                                child: Text(
                                  'Enter the password that you want for your account',
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              const SizedBox(height: 16),

                              Obx(() {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      obscureText: !controller.isPasswordVisible.value,
                                      onChanged: controller.onPasswordChanged,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        filled: true,
                                        fillColor: AppColors.white,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            controller.isPasswordVisible.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: controller.isPasswordVisible.value
                                                ? AppColors.primary
                                                : AppColors.border,
                                          ),
                                          onPressed: controller.togglePasswordVisibility,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: AppColors.border,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Text(
                                          "Password Strength:",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textDark,
                                          ),
                                        ),

                                        Obx(() => Text(
                                          "${controller.passwordStrengthLabel.value}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: controller.getStrengthColor(),
                                          ),
                                        )),

                                      ],
                                    ),

                                    const SizedBox(height: 5),
                                    LinearProgressIndicator(
                                      value: controller.passwordStrength.value,
                                      color: controller.getStrengthColor(),
                                      backgroundColor: Colors.grey.shade300,
                                      minHeight: 4,
                                    ),

                                const SizedBox(height: 15),

                                Text(
                                "Password Essentials:",
                                style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textDark,
                                ),
                                ),
                                    const SizedBox(height: 3),
                                    _buildCheck("Minimum 8 characters", controller.hasMinLength),
                                    _buildCheck("At least 1 uppercase letter", controller.hasUppercase),
                                    _buildCheck("At least 1 lowercase letter", controller.hasLowercase),
                                    _buildCheck("At least 1 number", controller.hasNumber),
                                  ],
                                );
                              }),
                              SizedBox(height: 100,),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

              ),
              Obx(() {
                final isPasswordValid = controller.isPasswordValid.value;
                return Container(
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
                    text: "Reset Password",
                    onPressed: isPasswordValid ? controller.resetPassword : null,
                    isEnabled: isPasswordValid,
                  ),
                );
              }),
            ],
          ),
        ),


      ),
    );
  }

  Widget _buildCheck(String text, RxBool isValid) {
    return Obx(() => Row(
      children: [
        Icon(
          isValid.value ? Icons.check_circle : Icons.cancel,
          size: 18,
          color: isValid.value ? AppColors.green : AppColors.red,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 13),
        )
      ],
    ));



  }
}


class ResetSuccessSheet extends StatelessWidget {
  final VoidCallback onClose;

  const ResetSuccessSheet({super.key, required this.onClose});


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.hintText,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Center(
                  child: Icon(Icons.check_circle, color: AppColors.primary, size: 64),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    "Password Reset Successfully!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "You can now use your new password to log in.",
                    style: TextStyle(color: AppColors.textDark),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(
                  text: "Back to Login",
                  onPressed: controller.loginWithEmail, // ✅ use correct parameter
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
