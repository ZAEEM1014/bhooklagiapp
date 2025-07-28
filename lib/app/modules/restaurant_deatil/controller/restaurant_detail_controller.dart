import 'package:get/get.dart';

import '../../../models/restaurant_model.dart';

class RestaurantDetailController extends GetxController {
  late Restaurant restaurant;

  final selectedTabIndex = 0.obs;



  List<String> get sectionTitles => restaurant.sections.map((e) => e.title).toList();

  void setRestaurant(Restaurant data) {
    restaurant = data;
  }

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  // 👇 Add these for product popup
  final RxBool isProductDetailVisible = false.obs;
  final Rxn<Product> selectedProduct = Rxn<Product>();

  void showProductDetail(Product product) {
    selectedProduct.value = product;
    isProductDetailVisible.value = true;
  }

  void hideProductDetail() {
    isProductDetailVisible.value = false;
    selectedProduct.value = null;
  }
}
