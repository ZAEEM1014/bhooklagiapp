import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_bar_normal.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../theme/app_colors.dart';
import '../controller/add_card_contoller.dart';


class AddCardScreen extends GetView<AddCardController> {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'Add a credit or debit card'),
      body: SafeArea(
        child: Stack(
          children: [
            /// Main content
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          hintText: 'Card number',
                          keyboardType: TextInputType.number,
                          controller: controller.cardNumberController,
                          onChanged: (_) => controller.checkFormValidity(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                hintText: 'MM/YY',
                                keyboardType: TextInputType.datetime,
                                controller: controller.expiryController,
                                onChanged: (_) => controller.checkFormValidity(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AppTextField(
                                hintText: 'CVC',
                                keyboardType: TextInputType.number,
                                controller: controller.cvcController,
                                onChanged: (_) => controller.checkFormValidity(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          hintText: 'Name of the card holder',
                          keyboardType: TextInputType.name,
                          controller: controller.nameController,
                          onChanged: (_) => controller.checkFormValidity(),
                        ),
                        const SizedBox(height: 16),
                        Obx(() => Row(
                          children: [
                            Checkbox(
                              value: controller.saveCard.value,
                              activeColor: AppColors.primary,
                              onChanged: (value) =>
                              controller.saveCard.value = value ?? true,
                            ),
                            const Expanded(
                              child: Text(
                                'Save this card for a faster checkout next time',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(height: 8),
                        const Text(
                          'By saving your card you grant us your consent to store \nyour payment method for future orders.  ',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      // Space for bottom button
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
                final isEnabled = controller.isFormFilled.value;
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
                      text: "Done",
                      onPressed: isEnabled ? controller.submitCard : null,

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
