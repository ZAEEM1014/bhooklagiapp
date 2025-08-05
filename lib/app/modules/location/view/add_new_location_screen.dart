import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../widgets/app_bar_normal.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../theme/app_colors.dart';
import '../controller/location-controller.dart';


class AddLocationScreen extends StatelessWidget {
  AddLocationScreen({super.key});

  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: 'Select Location'),
      body: Stack(
        children: [
          /// MAP WIDGET
          Obx(() => Positioned.fill(
            top: 100,
            child: FlutterMap(
              options: MapOptions(
                center: controller.selectedPoint.value,
                zoom: 13.0,
                onTap: (tapPosition, latLng) {
                  controller.updateLocationFromCoordinates(latLng.latitude, latLng.longitude);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),

                Obx(() => MarkerLayer(
                  markers: [
                    Marker(
                      point: controller.selectedPoint.value,
                      width: 60,
                      height: 60,
                      child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                  ],
                )),
              ],
            )

          )),

          /// SEARCH BAR
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: AppTextField(
              hintText: 'Search your location',
              keyboardType: TextInputType.text,
              onChanged: (value) {
                if (value.length > 3) {
                  controller.searchLocation(value);
                }
              },
            ),
          ),

          /// CONFIRM BUTTON
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: AppButton(
              text: 'Confirm Location',
                onPressed: () {
                  controller.saveOrUpdateAddress("Home"); // Or use dynamic label input
                }
            ),
          ),
        ],
      ),
    );
  }
}
