import 'package:get/get.dart';

import '../modules/checkout/controller/add_card_contoller.dart';


class AddCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCardController>(() => AddCardController());
  }
}
