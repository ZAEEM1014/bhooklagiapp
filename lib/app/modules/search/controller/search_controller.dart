// search_controller.dart
import 'package:get/get.dart';

class SearchController extends GetxController {
  var restaurantSearches = [
    'kfc', 'mcdonalds', 'ice cream', 'burger', 'burger king',
    'dominos', 'pizza', 'pizza hut',
  ].obs;

  var shopSearches = [
    '7up', 'ice cream', 'burger', 'cheese it',
  ].obs;

  var searchText = ''.obs;

  void updateSearchText(String value) {
    searchText.value = value;
  }
}
