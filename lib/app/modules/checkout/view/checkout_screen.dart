import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_bar_normal.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../location/controller/location-controller.dart';
import '../controller/checkout_controller.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/payment_method _controller.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({super.key});
  final locationController = Get.find<LocationController>();

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final CheckoutController controller = Get.find<CheckoutController>();
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.subtotal.value = cartController.totalPrice;
    });
  }

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
            const SizedBox(height: 2),
            DeliveryAddressCard(),
            const SizedBox(height: 2),
            DeliveryOptionsCard(),
            const SizedBox(height: 2),
            const PaymentMethodCard(),
            const SizedBox(height: 20),
            OrderSummaryCard(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        final discount = controller.discount;
        final deliveryFee = controller.deliveryFee;
        final platformFee = controller.platformFee;
        final total = controller.total;
        final originalTotal = controller.originalTotal;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "(incl. fees and tax)",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Rs. ${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (discount > 0)
                        Text(
                          "Rs. ${originalTotal.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.hintText,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Select payment method",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
          Text(value, style: const TextStyle(color: AppColors.textDark)),
        ],
      ),
    );
  }
}

class DeliveryAddressCard extends StatelessWidget {
  final CheckoutController controller = Get.find<CheckoutController>();
  final locationController = Get.put(LocationController());

  DeliveryAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            children: const [
              Icon(Icons.location_on_outlined, color: AppColors.textDark),
              SizedBox(width: 8),
              Text(
                "Delivery address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.textDark,
                ),
              ),
              Spacer(),
              Icon(Icons.edit, size: 20, color: AppColors.textDark),
            ],
          ),

          const SizedBox(height: 12),

          /// Map Image (static)
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: FlutterMap(
                        options: MapOptions(
                          center: locationController.selectedPoint.value,
                          zoom: 13.0,
                          interactiveFlags:
                              InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            userAgentPackageName: 'com.example.yourapp',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 40,
                                height: 40,
                                point: locationController.selectedPoint.value,
                                child: const Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Obx(() {
                      final parts =
                          locationController.location.value.split(',');
                      final firstLine = parts.length > 1
                          ? '${parts.first.trim()}, ${parts[1].trim()}'
                          : locationController.location.value;
                      final city = parts.length > 2 ? parts[2].trim() : '';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Location',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            firstLine,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          if (city.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                city,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                ],
              )),

          const SizedBox(height: 16),

          /// Note to rider (outlined input)
          TextField(
            decoration: InputDecoration(
              hintText: "Note to rider - e.g. landmark",
              hintStyle: TextStyle(color: AppColors.hintText),
              filled: true,
              fillColor: AppColors.background,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.border),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Leave at the door toggle
        ],
      ),
    );
  }
}

class DeliveryOptionsCard extends StatelessWidget {
  final CheckoutController controller = Get.find<CheckoutController>();

  DeliveryOptionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivery options",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            _BouncyOption(
              label: "Standard",
              time: "40 - 60 mins",
              extraFee: 0,
              isSelected: controller.selectedDelivery.value == "Standard",
              onTap: () => controller.selectDeliveryOption("Standard"),
            ),
            const SizedBox(height: 12),
            _BouncyOption(
              label: "Priority",
              time: "35 - 50 mins",
              extraFee: 70,
              isSelected: controller.selectedDelivery.value == "Priority",
              onTap: () => controller.selectDeliveryOption("Priority"),
            ),
          ],
        ),
      ),
    );
  }
}

class _BouncyOption extends StatefulWidget {
  final String label;
  final String time;
  final double extraFee;
  final bool isSelected;
  final VoidCallback onTap;

  const _BouncyOption({
    required this.label,
    required this.time,
    required this.extraFee,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_BouncyOption> createState() => _BouncyOptionState();
}

class _BouncyOptionState extends State<_BouncyOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      lowerBound: 0.95,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _controller.value = 1.0;
  }

  void _animateTap() async {
    await _controller.reverse();
    await _controller.forward();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _animateTap,
      child: ScaleTransition(
        scale: _controller,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.isSelected ? AppColors.primary : AppColors.border,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.label}  ${widget.time}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              if (widget.extraFee > 0)
                Text(
                  "+ Rs. ${widget.extraFee.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

  void _openSheet(BuildContext context) {
    showPaymentMethodSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentMethodController>();

    return Obx(() {
      final hasMethod = controller.selectedMethod.value != PaymentType.none;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment method",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            if (hasMethod)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      controller.selectedDetails.value,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _openSheet(context),
                    child: const Text("Change"),
                  ),
                ],
              )
            else
              GestureDetector(
                onTap: () => _openSheet(context),
                child: Row(
                  children: const [
                    Icon(Icons.add, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Add a payment method"),
                  ],
                ),
              ),
            const Divider(height: 24),
          ],
        ),
      );
    });
  }
}

class OrderSummaryCard extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  final CheckoutController checkoutController = Get.find<CheckoutController>();

  OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cart = cartController.currentCart;
      final subtotal = cartController.totalPrice;
      final discount = checkoutController.discount;
      final deliveryFee = checkoutController.deliveryFee;
      final platformFee = checkoutController.platformFee;
      final total = checkoutController.total;

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
                Text("Order summary",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                    Text(
                        'Rs. ${(product.price * quantity).toStringAsFixed(2)}'),
                  ],
                ),
              );
            }).toList(),
            const Divider(height: 24, thickness: 1),
            _buildSummaryRow("Subtotal", 'Rs. ${subtotal.toStringAsFixed(2)}'),
            _buildSummaryRow("Discount", '- Rs. ${discount.toStringAsFixed(2)}',
                valueColor: AppColors.primary),
            _buildSummaryRow(
                "Delivery Fee", 'Rs. ${deliveryFee.toStringAsFixed(2)}'),
            _buildSummaryRow(
                "Platform Fee", 'Rs. ${platformFee.toStringAsFixed(2)}'),
            const Divider(height: 24, thickness: 1),
            _buildSummaryRow("Total", 'Rs. ${total.toStringAsFixed(2)}',
                valueColor: Colors.black),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                // Apply voucher logic
              },
              child: Text(
                "Apply a voucher",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSummaryRow(String title, String value,
      {Color valueColor = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: valueColor,
                  fontSize: 14)),
        ],
      ),
    );
  }
}

void showPaymentMethodSheet(BuildContext context) {
  final controller = Get.find<PaymentMethodController>();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final selected = controller.selectedMethod.value;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select a payment method",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              _paymentOptionTile(
                title: "Cash",
                icon: Icons.money,
                selected: selected == PaymentType.cash,
                onTap: () {
                  controller.setMethod(PaymentType.cash, "Cash on Delivery");
                  Get.back(); // close bottom sheet
                },
              ),
              _paymentOptionTile(
                title: "Credit or Debit Card",
                icon: Icons.credit_card,
                badgeText: "Rs. 350.00 off",
                selected: selected == PaymentType.creditCard,
                onTap: () {
                  controller.setMethod(PaymentType.creditCard, "Card");
                  Get.back(); // close sheet first
                  Get.toNamed(AppRoutes.addCard);
                },
              ),
              _paymentOptionTile(
                title: "JazzCash",
                icon: Icons.account_balance_wallet,
                selected: selected == PaymentType.jazzCash,
                onTap: () {
                  controller.setMethod(PaymentType.jazzCash, "JazzCash");
                  Get.back();
                  Get.toNamed(AppRoutes.jazzCash);
                },
              ),
              const SizedBox(height: 10),
            ],
          );
        }),
      );
    },
  );
}

Widget _paymentOptionTile({
  required String title,
  required IconData icon,
  bool selected = false,
  String? badgeText,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: selected ? AppColors.primary : Colors.black),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: selected ? AppColors.primary : Colors.black,
      ),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (badgeText != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              badgeText,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        const SizedBox(width: 8),
        Icon(
          selected ? Icons.check_circle : Icons.arrow_forward_ios,
          color: selected ? AppColors.primary : AppColors.border,
          size: selected ? 20 : 16,
        ),
      ],
    ),
    onTap: onTap,
  );
}
