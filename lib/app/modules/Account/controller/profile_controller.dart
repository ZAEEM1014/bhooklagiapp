import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userName = 'zaeem'.obs;
  var credit = 0.0.obs;

  void onViewProfile() {
    Get.toNamed('/profile-detail');
  }

  void onOrdersTap() {
    Get.toNamed('/orders');
  }

  void onFavouritesTap() {
    Get.toNamed('/favourites');
  }

  void onAddressesTap() {
    Get.toNamed('/addresses');
  }

  void onTryPandapro() {
    Get.toNamed('/pandapro');
  }

  void onPandaRewards() {
    Get.toNamed('/rewards');
  }

  void onVouchers() {
    Get.toNamed('/vouchers');
  }

  void onInviteFriends() {
    Get.toNamed('/invite-friends');
  }

  void onHelpCenter() {
    Get.toNamed('/help-center');
  }

  void onBhookhlagiBusiness() {
    Get.toNamed('/business');
  }

  void onTermsPolicies() {
    Get.toNamed('/terms');
  }

  void onLogout() {
    Get.offAllNamed('/login');
  }
}
