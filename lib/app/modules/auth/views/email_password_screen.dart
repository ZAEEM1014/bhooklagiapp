import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:bhooklagiapp/app/theme/theme.dart';
import '../../../../widgets/app_button.dart';
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
                          IconButton(
                            icon: const Icon(Icons.arrow_back, size: 30),
                            onPressed: () => Get.back(),
                          ),
                          const SizedBox(height: 0),
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
                                    color: controller.isPasswordVisible.value?AppColors.primary:AppColors.border,
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
                          SizedBox(height: 2,),


                          Align(

                            child: TextButton(
                              onPressed: controller.forgotPassword,
                              child: Text(
                                "I forgot my password",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize:16,
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

              /// Bottom Action Buttons
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppButton(
                            text: "Log in with password",
                            onPressed: isPasswordValid ? controller.loginWithPassword : null,
                            isEnabled: isPasswordValid,
                          ),

                        ],
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
