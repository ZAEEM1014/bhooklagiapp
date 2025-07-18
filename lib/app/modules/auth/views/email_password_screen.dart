import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bhooklagiapp/constants/app_assets.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../theme/app_colors.dart';
import '../controllers/email_password_controller.dart';

class EmailPasswordScreen extends StatelessWidget {
  final controller = Get.put(EmailPasswordController());

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
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                AppAssets.emailVarLogo,
                                width: 160,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              "Log in with your email",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: GetBuilder<EmailPasswordController>(
                              builder: (controller) {
                                return Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: "Log in with your password to ",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      TextSpan(
                                        text: controller.email,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// Password Field
                          Obx(() {
                            return TextField(
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
                            );
                          }),
                          const SizedBox(height: 2),

                          Align(
                            child: TextButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  ForgotPasswordSheet(
                                    email: controller.email,
                                    onResetSuccess: controller.showSuccessBottomSheet,
                                  ),
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                );
                              },
                              child: Text(
                                "I forgot my password",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  );
                },
              ),

              /// Bottom Button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Obx(() {
                  final isPasswordValid = controller.isPasswordValid.value;

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
                        text: "Log in with password",
                        onPressed: isPasswordValid ? controller.loginWithPassword : null,
                        isEnabled: isPasswordValid,
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

// ------------------ Forgot Password Bottom Sheet ------------------ //

class ForgotPasswordSheet extends StatelessWidget {
  final String email;
  final VoidCallback onResetSuccess;

  const ForgotPasswordSheet({
    super.key,
    required this.email,
    required this.onResetSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController(text: email);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
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
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Text(
                  "Forgot your password?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Confirm your email and we’ll send you a link to set up a new one.",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 16),

                AppTextField(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  onChanged: (_) {},
                ),
                const SizedBox(height: 20),

                AppButton(
                  text: "RESET PASSWORD",
                  onPressed: () {
                    print("Reset link sent to: ${emailController.text}");
                    onResetSuccess();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ------------------ Success Sheet ------------------ //

class SuccessBottomSheet extends StatelessWidget {
  final VoidCallback onResetSuccess;

  const SuccessBottomSheet({Key? key, required this.onResetSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const Text("🔒", style: TextStyle(fontSize: 50)),
                const SizedBox(height: 12),
                const Text(
                  "Password Reset Email Sent",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 8),
                const Text(
                  "We’ve sent you an email with instructions to reset your password.",
                  style: TextStyle(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


