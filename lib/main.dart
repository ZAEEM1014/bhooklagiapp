import 'package:bhooklagiapp/widgets/controller/nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';


import 'app/modules/auth/controllers/auth_controller.dart';
import 'app/modules/cart/controller/cart_controller.dart';
import 'app/theme/theme.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController());
  Get.put(BottomNavController());
  Get.put(CartController());

  runApp(const BhookhLagiApp());
}

class BhookhLagiApp extends StatelessWidget {
  const BhookhLagiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bhookh Lagi',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
