import 'package:bhooklagiapp/widgets/app_bar_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/checkout_controller.dart';
import '../../../routes/app_routes.dart';

class OrderSuccessScreen extends GetView<CheckoutController> {
  final CartController cartController = Get.find<CartController>();

  OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: "Order Successful"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            /// Success Icon
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),

            /// Success Text
            const Text(
              "Thank you for your order!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your order has been placed successfully.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            /// Order Summary Card
            Obx(() {
              final cart = cartController.currentCart;
              final subtotal = cartController.totalPrice;
              final discount = controller.discount;
              final deliveryFee = controller.deliveryFee;
              final platformFee = controller.platformFee;
              final total = controller.total;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.receipt_long, color: Colors.black87),
                        SizedBox(width: 8),
                        Text("Order summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...cart.entries.map((entry) {
                      final product = entry.key;
                      final quantity = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text('$quantity x ${product.name}')),
                            Text('Rs. ${(product.price * quantity).toStringAsFixed(2)}'),
                          ],
                        ),
                      );
                    }).toList(),
                    const Divider(height: 24, thickness: 1),
                    _buildSummaryRow("Subtotal", 'Rs. ${subtotal.toStringAsFixed(2)}'),
                    _buildSummaryRow("Discount", '- Rs. ${discount.toStringAsFixed(2)}', valueColor: AppColors.primary),
                    _buildSummaryRow("Delivery Fee", 'Rs. ${deliveryFee.toStringAsFixed(2)}'),
                    _buildSummaryRow("Platform Fee", 'Rs. ${platformFee.toStringAsFixed(2)}'),
                    const Divider(height: 24, thickness: 1),
                    _buildSummaryRow("Total", 'Rs. ${total.toStringAsFixed(2)}', valueColor: Colors.black),
                  ],
                ),
              );
            }),

            const SizedBox(height: 30),

            /// Back to Home Button
            ElevatedButton(
              onPressed: () {

                Get.offAllNamed(AppRoutes.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Back to Home", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {Color valueColor = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value, style: TextStyle(fontWeight: FontWeight.w500, color: valueColor, fontSize: 14)),
        ],
      ),
    );
  }
}
