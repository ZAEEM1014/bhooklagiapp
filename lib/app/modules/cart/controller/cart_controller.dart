import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../models/restaurant_model.dart';

class CartController extends GetxController {
  final RxMap<String, Map<Product, int>> restaurantCarts = <String, Map<Product, int>>{}.obs;
  final RxInt totalItems = 0.obs; // NEW
  String? currentRestaurantId;

  Map<Product, int> get currentCart {
    if (currentRestaurantId == null) return {};
    return restaurantCarts.putIfAbsent(currentRestaurantId!, () => {});
  }

  void addToCart(Product product, int qty) {
    final cart = currentCart;
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + qty;
    } else {
      cart[product] = qty;
    }
    updateCartTotals();
  }

  void increaseQty(Product product) {
    if (currentCart.containsKey(product)) {
      currentCart[product] = currentCart[product]! + 1;
      updateCartTotals();
    }
  }

  void decreaseQty(Product product) {
    if (currentCart.containsKey(product) && currentCart[product]! > 1) {
      currentCart[product] = currentCart[product]! - 1;
      updateCartTotals();
    }
  }

  void removeItem(Product product) {
    currentCart.remove(product);
    updateCartTotals();
  }

  double get totalPrice {
    return currentCart.entries
        .map((e) => e.key.price * e.value)
        .fold(0.0, (prev, curr) => prev + curr);
  }

  void updateCartTotals() {
    restaurantCarts.refresh(); // ensure GetX picks up changes
    totalItems.value = currentCart.values.fold(0, (sum, qty) => sum + qty);
  }

  @override
  void onInit() {
    super.onInit();
    updateCartTotals(); // Initialize correctly at app start
  }
}
