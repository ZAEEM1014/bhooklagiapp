import 'package:bhooklagiapp/app/theme/theme.dart';
import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor:AppColors.white, // Your custom purple color
        statusBarIconBrightness: Brightness.dark, // Makes status bar icons white
        statusBarBrightness: Brightness.dark, // For iOS
      ),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Image.asset(
            AppAssets.mainLogo,
            width: 300,
          ),
        ),
      ),
    );
  }
}
