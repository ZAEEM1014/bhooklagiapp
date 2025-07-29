import 'package:get/get.dart';
import '../../../models/restaurant_model.dart';

class CartController extends GetxController {
  /// Map of restaurantId -> (Product -> Quantity)
  final RxMap<String, Map<Product, int>> restaurantCarts =
      <String, Map<Product, int>>{}.obs;

  /// Total item count (for badge, summary, etc.)
  final RxInt totalItems = 0.obs;

  /// Currently selected restaurant
  String? currentRestaurantId;

  /// Get current restaurant cart
  Map<Product, int> get currentCart {
    if (currentRestaurantId == null) return {};
    return restaurantCarts.putIfAbsent(currentRestaurantId!, () => {});
  }

  /// Add or update product quantity in current cart
  void addToCart(Product product, int qty) {
    final cart = currentCart;
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + qty;
    } else {
      cart[product] = qty;
    }
    updateCartTotals();
  }

  /// Increase quantity of a product
  void increaseQty(Product product) {
    if (currentCart.containsKey(product)) {
      currentCart[product] = currentCart[product]! + 1;
      updateCartTotals();
    }
  }

  /// Decrease quantity (min 1)
  void decreaseQty(Product product) {
    if (currentCart.containsKey(product) && currentCart[product]! > 1) {
      currentCart[product] = currentCart[product]! - 1;
      updateCartTotals();
    }
  }

  /// Remove product from cart
  void removeItem(Product product) {
    currentCart.remove(product);
    updateCartTotals();
  }

  /// Alias for removeItem() to match UI tap handler
  void removeFromCart(Product product) => removeItem(product);

  /// Compute total price of cart
  double get totalPrice {
    return currentCart.entries
        .map((e) => e.key.price * e.value)
        .fold(0.0, (prev, curr) => prev + curr);
  }

  /// Recalculate totalItems and refresh observable
  void updateCartTotals() {
    restaurantCarts.refresh(); // ensure GetX picks up internal changes
    totalItems.value = currentCart.values.fold(0, (sum, qty) => sum + qty);
  }

  @override
  void onInit() {
    super.onInit();
    updateCartTotals(); // initialize item count
  }
}
