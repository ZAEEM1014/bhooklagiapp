import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_bar_normal.dart';
import '../../../theme/app_colors.dart';
import '../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  final String restaurantId;

  CartScreen({Key? key, required this.restaurantId}) : super(key: key) {
    controller.setCurrentRestaurant(restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Your Cart',
        subtitle: controller.currentRestaurant?.name,
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

              return Stack(
                children: [
                  Container(
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
                          child: Image.asset(
                            product.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name,
                                  style: const TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text(
                                product.description,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _qtyButton(Icons.remove, () => controller.decreaseQty(product)),
                                  const SizedBox(width: 8),
                                  Text('$qty', style: const TextStyle(fontSize: 16)),
                                  const SizedBox(width: 8),
                                  _qtyButton(Icons.add, () => controller.increaseQty(product)),
                                  const Spacer(),
                                  Text(
                                    "Rs. ${(product.price * qty).toStringAsFixed(2)}",
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: GestureDetector(
                      onTap: () => controller.removeFromCart(product),
                      child: const Icon(Icons.close, size: 20, color: Colors.grey),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 100),
          ],
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Color(0x22000000),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: controller.goToCheckout,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            "Checkout",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
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
