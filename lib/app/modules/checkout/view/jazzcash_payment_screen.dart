import 'package:bhooklagiapp/widgets/app_bar_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../constants/app_assets.dart'; // Optional: Replace with your logo
import '../../../../widgets/app_button.dart';
import '../../../theme/app_colors.dart';
import '../controller/jazzcash_payment_controller.dart';

class JazzCashPaymentScreen extends GetView<JazzCashPaymentController> {
  const JazzCashPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Pay with JazzCash'),
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
                        const SizedBox(height: 10),



                        const Text(
                          "Enter your JazzCash details to proceed. Make sure your wallet has sufficient balance.",
                          style: TextStyle(fontSize: 16, color: AppColors.textDark),
                        ),
                        const SizedBox(height: 24),

                        TextField(
                          controller: controller.mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Mobile number",
                            hintText: "03XXXXXXXXX",
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextField(
                          controller: controller.cnicController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "CNIC (Last 6 digits)",
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppColors.border),
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

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Obx(() {
                final isEnabled = controller.isButtonEnabled.value;
                return SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.border.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: AppButton(
                      text: "Pay Now",
                      onPressed: isEnabled ? controller.submitPayment : null,
                      isEnabled: isEnabled,
                    ),



                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
