import 'package:get/get.dart';

import '../../../../widgets/controller/restaurant_card_controller.dart';
import '../../../models/restaurant_model.dart';
import '../../../routes/app_routes.dart';


class CartController extends GetxController {
  /// Carts per restaurant
  final RxMap<String, Map<Product, int>> restaurantCarts = <String, Map<Product, int>>{}.obs;

  /// Current selected restaurant ID
  String? currentRestaurantId;

  /// Total items in cart
  final RxInt totalItems = 0.obs;

  /// Set current restaurant (called when opening restaurant or cart)
  void setCurrentRestaurant(String id) {
    currentRestaurantId = id;
    restaurantCarts.putIfAbsent(id, () => {});
    updateCartTotals();
  }

  /// Get current cart
  Map<Product, int> get currentCart {
    if (currentRestaurantId == null && restaurantCarts.isNotEmpty) {
      currentRestaurantId = restaurantCarts.keys.last;
    }
    if (currentRestaurantId == null) return {};
    return restaurantCarts.putIfAbsent(currentRestaurantId!, () => {});
  }

  /// Add product to cart
  void addToCart(Product product, int qty) {
    final cart = currentCart;
    cart[product] = (cart[product] ?? 0) + qty;
    updateCartTotals();
  }

  /// Increase product quantity
  void increaseQty(Product product) {
    if (currentCart.containsKey(product)) {
      currentCart[product] = currentCart[product]! + 1;
      updateCartTotals();
    }
  }

  /// Decrease product quantity or remove
  void decreaseQty(Product product) {
    if (currentCart.containsKey(product)) {
      if (currentCart[product]! > 1) {
        currentCart[product] = currentCart[product]! - 1;
      } else {
        currentCart.remove(product);
      }
      updateCartTotals();
    }
  }

  /// Remove product from cart
  void removeItem(Product product) {
    currentCart.remove(product);
    updateCartTotals();
  }

  void removeFromCart(Product product) => removeItem(product);

  /// Get current cart total price
  double get totalPrice {
    return currentCart.entries
        .map((e) => e.key.price * e.value)
        .fold(0.0, (sum, value) => sum + value);
  }

  /// Get current restaurant from controller
  Restaurant? get currentRestaurant {
    if (currentRestaurantId == null) return null;
    final controller = Get.find<RestaurantController>();
    return controller.getRestaurantById(currentRestaurantId!);
  }

  /// Recalculate total quantity
  void updateCartTotals() {
    restaurantCarts.refresh();
    totalItems.value = currentCart.values.fold(0, (sum, qty) => sum + qty);
  }

  void goToCheckout() {
    // Perform any validation or logic here
    print('Order placed!');

    // Navigate to confirmation
    Get.offNamed(AppRoutes.checkout);
  }

  @override
  void onInit() {
    super.onInit();
    updateCartTotals();
  }
}
