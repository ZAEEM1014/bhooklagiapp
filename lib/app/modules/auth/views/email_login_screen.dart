import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:bhooklagiapp/app/theme/theme.dart';
import '../../../../widgets/app_button.dart';
import '../controllers/emial_login_controller.dart';


class EmailLoginScreen extends StatelessWidget {
  final controller = Get.put(EmailLoginController());

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
              /// Main Scrollable Content
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, size: 30),
                              onPressed: () => Get.back(),
                            ),
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

                          Center(
                            child: Text(
                              "What's your email?",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Center(
                            child: Text(
                              "We'll check if you have an account",
                              style: TextStyle(color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 20),

                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: controller.onEmailChanged,
                            decoration: InputDecoration(
                              hintText: 'Email',
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
                  final isEnabled = controller.isEmailValid.value;
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
                        onPressed: isEnabled ? controller.verifyEmail : null,
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
