import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/restaurant_model.dart';
import '../../../theme/app_colors.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/view/cart_screen.dart';
import '../../favourites/controller/favourite_countroller.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  final favoriteController = Get.find<FavoriteController>();



  RestaurantDetailScreen({super.key, required this.restaurant});
  final CartController cartController = Get.find<CartController>();



  @override

  Widget build(BuildContext context) {
    cartController.currentRestaurantId = restaurant.id;
    return Obx(() {
      final currentCartItems = cartController.currentCart.entries.toList();
      final totalAmount = currentCartItems.fold<double>(
        0.0,
            (sum, item) => sum + item.key.price * item.value,
      );
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: cartController.currentCart.isEmpty
            ? null
            : Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: AppColors.border,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => CartScreen(restaurantId: restaurant.id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              children: [
                // Item count circle
                Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cartController.totalItems.toString(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'View your cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        restaurant.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Rs. ${cartController.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),




        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: _RestaurantHeader(restaurant: restaurant,favoriteController: favoriteController,)),
            // Gradient background behind the sticky search header
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.08),
                        offset: const Offset(0, -4), // top shadow
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                    border: const Border(
                      top: BorderSide(
                        color: Color(0xFFE0E0E0),
                        // subtle light grey top border
                        width: 1,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 20, bottom: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      // Search Field
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Search in menu",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Tabs
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: restaurant.sections
                              .map((section) =>
                              Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: Text(
                                  section.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final section = restaurant.sections[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, -4), // Top shadow
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 10,
                              offset: const Offset(0, 6), // Bottom shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔥 Section Title
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                child: Text(
                                  "🔥 ${section.title}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // 🧺 Product Grid
                              GridView.builder(
                                itemCount: section.products.length,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.75,
                                ),
                                itemBuilder: (_, index) {
                                  final product = section.products[index];
                                  return GestureDetector(
                                    onTap: () =>
                                        showProductDetailSheet(
                                            context, product),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        // 📷 Product Image with Add button
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius
                                                  .circular(14),
                                              child: Image.asset(
                                                product.image,
                                                height: 140,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 8,
                                              right: 8,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .textDark),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.05),
                                                      blurRadius: 4,
                                                      offset: const Offset(
                                                          0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 20,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 8),

                                        // 🍔 Product Name
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            product.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                        const SizedBox(height: 4),

                                        // 💰 Price
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            "Rs. ${product.price
                                                .toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: restaurant.sections.length,
              ),
            )

          ],
        ),
      );

    });
  }
}

class _RestaurantHeader extends StatelessWidget {
  final Restaurant restaurant;
  final FavoriteController favoriteController;

  const _RestaurantHeader({required this.restaurant,    required this.favoriteController,});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 24),
                onPressed: () {
                  Get.back();
                },
              ),

              Row(
                children: [
                  const Icon(Icons.info_outline, size: 20),
                  const SizedBox(width: 5),




                  Obx(() {
                    final isFav = favoriteController.isFavorite(restaurant.id );
                    return TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: isFav ? AppColors.black: AppColors.primary,
                        end: isFav ? AppColors.primary : AppColors.black,
                      ),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, color, child) {
                        return IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: color,
                            size: 24,
                          ),
                          onPressed: () {
                            favoriteController.toggleFavorite(restaurant.id );
                          },
                        );
                      },
                    );
                  }),







                  const SizedBox(width: 5),
                  const Icon(Icons.share, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(restaurant.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              restaurant.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                5,
                    (index) =>
                const Icon(Icons.star, size: 14, color: Colors.orange),
              ),
              const SizedBox(width: 4),
              Text(
                "${restaurant.rating} (${restaurant.reviews}+ ratings)",
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.delivery_dining, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Delivery ${restaurant.deliveryTime}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text("Change", style: TextStyle(color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      restaurant.freeDelivery
                          ? "Free delivery"
                          : "Delivery charges apply",
                      style: TextStyle(fontSize: 12, color: AppColors.primary),
                    ),
                    Text(
                      "  Min. order Rs. 149.00",
                      style: TextStyle(fontSize: 12, color: AppColors.hintText),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: List.generate(
              (restaurant.offers.length / 2).ceil(),
                  (rowIndex) {
                final start = rowIndex * 2;
                final end = (start + 2) <= restaurant.offers.length
                    ? start + 2
                    : restaurant.offers.length;
                final currentRow = restaurant.offers.sublist(start, end);

                return Row(
                  mainAxisAlignment: currentRow.length == 1
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: currentRow.map((offer) {
                    final isFirst = restaurant.offers.indexOf(offer) == 0;
                    final bgColor = isFirst
                        ? AppColors.primary.withOpacity(0.08)
                        : Colors.white;
                    final iconColor =
                    isFirst ? AppColors.primary : Colors.deepPurple;

                    final offerCard = Container(
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      width: currentRow.length == 1 ? 250 : null,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.local_offer_outlined,
                              color: iconColor, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  offer.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  offer.description,
                                  style: const TextStyle(
                                      fontSize: 10, color: AppColors.textDark),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );

                    return currentRow.length == 1
                        ? offerCard
                        : Expanded(child: offerCard);
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
void showProductDetailSheet(BuildContext context, Product product) {

  final RxInt quantity = 1.obs;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🖼️ Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:  Image.asset(
                    product.image,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),

                // 🧁 Name & Price
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Rs. ${product.price.toStringAsFixed(0)}", style: const TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 12),

                // 📝 Description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(product.description, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                ),
                const SizedBox(height: 16),

                // ➕➖ Quantity and Add to Cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Row(
                      children: [
                        _qtyButton(Icons.remove, () {
                          if (quantity.value > 1) quantity.value--;
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        _qtyButton(Icons.add, () {
                          quantity.value++;
                        }),
                      ],
                    )),
                    // ADD TO CART BUTTON
                    SizedBox(
                      height: 50,
                      width: 180,
                      child:ElevatedButton(
                        onPressed: () {
                          final cartController = Get.find<CartController>();
                          cartController.addToCart(product, quantity.value);
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                        child: const Text("Add to Cart", style: TextStyle(color: AppColors.white)),
                      ),

                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _qtyButton(IconData icon, VoidCallback onTap) {
  return Material(
    color: Colors.transparent, // Needed for ripple to show properly
    shape: const CircleBorder(),
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
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


