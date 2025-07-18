import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/theme/scroll_behavior.dart';
import 'app/theme/theme.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() {
  runApp(const BhookhLagiApp());
}

class BhookhLagiApp extends StatelessWidget {
  const BhookhLagiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: NoGlowScrollBehavior (),
      title: 'Bhookh Lagi',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
