import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhooklagiapp/app/theme/theme.dart';

import '../controllers/mobile_verification_controller.dart'; // Your theme file


class MobileVerificationScreen extends StatelessWidget {
  final controller = Get.put(MobileVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.close, size: 30),
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/logos/purplelogo.png', // Update this path
                        width: 150,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "What's your mobile number?",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "We need this to verify and secure your account",
                      style: TextStyle(color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                    () => Row(
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
                ),
              ),
              const SizedBox(height: 30),
              Obx(() {
                final isEnabled = controller.isPhoneValid;
                return ElevatedButton(
                  onPressed: isEnabled ? () => print("Continue tapped") : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEnabled ? const Color(0xFF9d02ff) : Colors.grey[300],
                    foregroundColor: isEnabled ? Colors.white : Colors.grey[600],
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Continue"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
