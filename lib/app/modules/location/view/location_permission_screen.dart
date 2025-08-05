import 'package:bhooklagiapp/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_button.dart';
import '../controller/location-controller.dart'; // ✅ Make sure the controller here is the unified LocationController
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.find<LocationController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),
            Image.asset(
              AppAssets.locationLogo,
              height: 260,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    "Allow location access on the next screen for:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildInfoRow(
                    icon: Icons.delivery_dining,
                    text: "Searching the best restaurants and shops near you",
                  ),
                  const SizedBox(height: 20),
                  _buildInfoRow(
                    icon: Icons.store_mall_directory_outlined,
                    text: "Receiving more accurate and faster delivery",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: AppButton(
                text: "Continue",
                onPressed: () async {
                  await locationController.fetchCurrentLocation();
                  Get.offAllNamed(AppRoutes.mainwrapper);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: AppColors.textDark),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
