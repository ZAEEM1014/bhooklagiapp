import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_bar_normal.dart';
import '../../../theme/app_colors.dart';
import '../controller/checkout_controller.dart';

class CheckOutScreen extends StatelessWidget {
  final CheckoutController controller = Get.find<CheckoutController>();

  CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomAppBar(title: 'Check Out'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Step Progress Bar
            const SizedBox(height: 20),

            /// Delivery Address
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: AppColors.textDark),
                      SizedBox(width: 8),
                      Text("Delivery address", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      Spacer(),
                      Icon(Icons.edit, size: 20, color: AppColors.textDark),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset("assets/map_sample.png", height: 100, width: double.infinity, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 8),
                  const Text("15 A Chenab Gate Road\nGujranwala", style: TextStyle(fontSize: 14, color: AppColors.textDark)),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Note to rider - e.g. landmark",
                      hintStyle: TextStyle(color: AppColors.hintText),
                      filled: true,
                      fillColor: AppColors.neutralLight,
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                            "Change issues? You can ask the rider to top-up your wallet.",
                            style: TextStyle(color: AppColors.textDark),
                          )),
                      Obx(() => Switch(
                        value: controller.topUpWallet.value,
                        onChanged: controller.toggleTopUpWallet,
                        activeColor: AppColors.primary,
                      )),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// Delivery Options
            const Text("Delivery options", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 12),
            Obx(() => Column(
              children: [
                deliveryOption("Standard", "40 - 60 mins", 0),
                const SizedBox(height: 10),
                deliveryOption("Priority", "35 - 50 mins", 70),
              ],
            )),
            const SizedBox(height: 100),
          ],
        ),
      ),

      /// Bottom Summary
      bottomNavigationBar: Obx(() {
        final subtotal = controller.subtotal.value;
        final total = controller.total;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              row("Subtotal", "Rs. ${subtotal.toStringAsFixed(2)}"),
              row("Delivery Fee", "Rs. ${controller.deliveryFee.toStringAsFixed(2)}"),
              row("Taxes", "Rs. ${controller.tax.toStringAsFixed(2)}"),
              const Divider(height: 20),
              ElevatedButton(
                onPressed: controller.placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  "Place order",
                  style: TextStyle(fontSize: 16, color: AppColors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget stepCircle(String number, String label) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.textDark,
          child: Text("1", style: TextStyle(color: AppColors.white, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
      ],
    );
  }

  Widget deliveryOption(String label, String time, double extraFee) {
    return InkWell(
      onTap: () => controller.selectDeliveryOption(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.selectedDelivery.value == label ? AppColors.primary : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Expanded(child: Text("$label  $time", style: const TextStyle(color: AppColors.textDark))),
            if (extraFee > 0)
              Text("+ Rs. ${extraFee.toStringAsFixed(0)}", style: const TextStyle(color: AppColors.textDark)),
          ],
        ),
      ),
    );
  }

  Widget row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
          Text(value, style: const TextStyle(color: AppColors.textDark)),
        ],
      ),
    );
  }
}
