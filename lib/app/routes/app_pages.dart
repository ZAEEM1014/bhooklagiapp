// lib/app/routes/app_pages.dart
import 'package:bhooklagiapp/app/modules/auth/views/email_login_screen.dart';
import 'package:bhooklagiapp/app/modules/auth/views/email_password_screen.dart';
import 'package:bhooklagiapp/app/modules/auth/views/mobile_verification_screen.dart';
import 'package:bhooklagiapp/app/modules/restaurant_deatil/view/restaurant_deatil_screen.dart';
import 'package:get/get.dart';

import '../bindings/Checkount_binding.dart';
import '../bindings/add_card_binding.dart';
import '../bindings/auth_binding.dart';
import '../bindings/cart_binding.dart';

import '../bindings/favorite_binding.dart';
import '../bindings/grocery_binding.dart';
import '../bindings/jazzcash_binding.dart';
import '../bindings/location_binding.dart';

import '../bindings/navbar_binding.dart';
import '../bindings/restaurant_detai_binding.dart';
import '../models/restaurant_model.dart';
import '../modules/auth/controllers/auth_controller.dart';
import '../modules/auth/views/code_verification_screen.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/auth/views/reset_password_screen.dart';
import '../modules/cart/view/cart_screen.dart';
import '../modules/checkout/view/add_card_screen.dart';
import '../modules/checkout/view/checkout_screen.dart';

import '../modules/checkout/view/jazzcash_payment_screen.dart';
import '../modules/favourites/view/favourite_screen.dart' hide CartScreen;
import '../modules/grocery/view/grosery_screen.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/view/home_screen.dart';
import '../modules/location/view/add_new_location_screen.dart';
import '../modules/location/view/location_permission_screen.dart';
import '../modules/main_wrappeer/view/main_wrapper.dart';
import '../modules/splash/splash_bindings.dart';
import '../modules/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.mainwrapper,
      page: () => MainWrapper(),
      binding: MainWrapperBinding(), // ✅ register controller here
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),

    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),

    GetPage(
      name: AppRoutes.mobileverification,
      page: () => MobileVerificationScreen(),
      binding: MobileVerificationBinding(),
    ),

    GetPage(
      name: AppRoutes.codeverification,
      page: () => CodeVerificationScreen(),
      binding:CodeVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.emaillogin,
      page: () => EmailLoginScreen(),
      binding:EmailloginBinding(),
    ),

    GetPage(
      name: AppRoutes.emailpassword,
      page: () => EmailPasswordScreen(),
      binding:EmailPasswordBinding(),
    ),

    GetPage(
      name: AppRoutes.restaurantdetail,
      page: () {
        final restaurant = Get.arguments as Restaurant;
        return RestaurantDetailScreen(restaurant: restaurant);
      },
      binding: RestaurantDetailBinding(),
    ),



    GetPage(
      name: AppRoutes.resetpassword,
      page: () => ResetPasswordScreen(),
      binding:ResetPasswordBinding(),
    ),

    GetPage(
      name: AppRoutes.cart,
      page: () {
        final restaurantId = Get.arguments as String?;
        return CartScreen(restaurantId: restaurantId ?? '');
      },
      binding: CartBinding(),
    ),


    GetPage(
      name: AppRoutes.favorite,
      page: () =>  FavouriteScreen(), // Replace if you use another screen
      binding: FavouritesBinding(),
    ),

    GetPage(
      name: AppRoutes.grocery,
      page: () => GroceryScreen(),
      binding: GroceryBinding(),
    ),

    GetPage(
      name: AppRoutes.checkout,
      page: () => CheckOutScreen(),
      binding: CheckoutBinding(),
    ),

    GetPage(
      name: AppRoutes.addCard,
      page: () => const AddCardScreen(),
      binding: AddCardBinding(),
    ),

    GetPage(
      name: AppRoutes.jazzCash,
      page: () => const JazzCashPaymentScreen(),
      binding: JazzCashBinding(),
    ),
    GetPage(
      name: AppRoutes.locationPermission,
      page: () => const LocationPermissionScreen(),

    ),

    GetPage(
      name: AppRoutes.addLocation,
      page: () =>  AddLocationScreen(),
      binding: LocationBinding(),
    ),




  ];
}
