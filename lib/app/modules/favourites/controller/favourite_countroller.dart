import 'package:get/get.dart';
import '../../../../widgets/controller/restaurant_card_controller.dart';
import '../../../models/restaurant_model.dart';
import '../../../routes/app_routes.dart';
 // adjust if path differs

class FavoriteController extends GetxController {
  final RxSet<String> _favoriteRestaurantIds = <String>{}.obs;
  final RxList<Restaurant> allRestaurants = <Restaurant>[].obs;
  final RxList<Restaurant> favoriteRestaurants = <Restaurant>[].obs;

  final RxInt cartItemCount = 0.obs;
  final RxInt selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // Load all restaurants from RestaurantController (assuming it's registered)
    final restaurantController = Get.find<RestaurantController>();
    allRestaurants.assignAll(restaurantController.restaurants);

    // Reactively sync favoriteRestaurants when either list changes
    ever(_favoriteRestaurantIds, (_) => _syncFavorites());
    ever(allRestaurants, (_) => _syncFavorites());
  }

  bool isFavorite(String id) => _favoriteRestaurantIds.contains(id);

  void toggleFavorite(String id) {
    if (_favoriteRestaurantIds.contains(id)) {
      _favoriteRestaurantIds.remove(id);
    } else {
      _favoriteRestaurantIds.add(id);
    }
  }

  void _syncFavorites() {
    favoriteRestaurants.assignAll(
      allRestaurants.where((r) => _favoriteRestaurantIds.contains(r.id)),
    );
  }

  void goToExplore() {
    Get.offAllNamed(AppRoutes.home);
  }

  Set<String> get favorites => _favoriteRestaurantIds.toSet();

  /// Optional: use this if you're injecting mock data
  void loadDummyRestaurants(List<Restaurant> dummy) {
    allRestaurants.assignAll(dummy);
  }
}
