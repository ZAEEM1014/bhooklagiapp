import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController controller = Get.find<CartController>();


  CartScreen({super.key, required String restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Obx(() {
        final items = controller.currentCart;

        if (items.isEmpty) {
          return const Center(child: Text("Your cart is empty"));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...items.entries.map((entry) {
              final product = entry.key;
              final qty = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(product.image, width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(product.description, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _qtyButton(Icons.remove, () => controller.decreaseQty(product)),
                              const SizedBox(width: 8),
                              Text('$qty', style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 8),
                              _qtyButton(Icons.add, () => controller.increaseQty(product)),
                              const Spacer(),
                              Text("Rs. ${(product.price * qty).toStringAsFixed(2)}",
                                  style: const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 100),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final subtotal = controller.totalPrice;
        const delivery = 99.0;
        const tax = 14.99;
        final total = subtotal + delivery + tax;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 8, color: AppColors.black)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Subtotal", style: TextStyle(fontSize: 14)),
                Text("Rs. ${subtotal.toStringAsFixed(2)}"),
              ]),
              const SizedBox(height: 4),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Text("Delivery Fee", style: TextStyle(fontSize: 14)),
                Text("Rs. 99.00"),
              ]),
              const SizedBox(height: 4),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Text("Taxes", style: TextStyle(fontSize: 14)),
                Text("Rs. 14.99"),
              ]),
              const Divider(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Pay Rs. ${total.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16, color: AppColors.white)),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 16, color: Colors.black),
        ),
      ),
    );
  }
}
