// File: bindings/favourites_binding.dart
import 'package:get/get.dart';

import '../modules/favourites/controller/favourite_countroller.dart';


class FavouritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController >(() => FavoriteController ());
  }
}
