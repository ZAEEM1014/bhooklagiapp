import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../app/modules/cart/controller/cart_controller.dart';
import '../app/modules/home/controllers/home_controller.dart';
import '../app/routes/app_routes.dart';
import '../app/theme/app_colors.dart';
import '../app/modules/location/controller/location-controller.dart';

class HomeSliverAppBar extends StatelessWidget {
  final HomeController controller;
  final LocationController locationController = Get.find<LocationController>();


  HomeSliverAppBar({super.key, required this.controller});

  void _showEditLabelDialog(BuildContext context, int index, LocationController locationController) {
    final TextEditingController labelController =
    TextEditingController(text: locationController.savedAddresses[index].label);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Label'),
          content: TextField(
            controller: labelController,
            decoration: InputDecoration(hintText: "Enter label"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updated = locationController.savedAddresses[index].copyWith(
                  label: labelController.text,
                );
                locationController.savedAddresses[index] = updated;
                Get.back();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    final locationController = Get.find<LocationController>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Map & address display
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: 200,
                        child: Obx(() => FlutterMap(
                          options: MapOptions(
                            center: locationController.selectedPoint.value,
                            zoom: 13.0,
                            interactiveFlags:
                            InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              userAgentPackageName: 'com.example.yourapp',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 40,
                                  height: 40,
                                  point: locationController.selectedPoint.value,
                                  child: const Icon(Icons.location_on,
                                      size: 40, color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Obx(() {
                        final parts = locationController.location.value.split(',');
                        final firstLine = parts.length > 1
                            ? '${parts.first.trim()}, ${parts[1].trim()}'
                            : locationController.location.value;
                        final city = parts.length > 2 ? parts[2].trim() : '';

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Location',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(firstLine, style: Theme.of(context).textTheme.bodyLarge),
                            if (city.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  city,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Address chips
              Obx(() {
                const double chipWidth = double.infinity;
                const double chipHeight = 70;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    // 🔹 Original (GPS) Location Chip
                    GestureDetector(
                      onTap: () {
                        locationController.selectedAddressIndex.value = -1;
                        locationController.location.value =
                            locationController.originalLocation.value;
                        locationController.selectedPoint.value =
                            locationController.selectedPoint.value;
                      },
                      child: SizedBox(
                        width: chipWidth,
                        height: chipHeight,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: locationController.selectedAddressIndex.value == -1
                                ? Colors.deepPurple.shade100
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: locationController.selectedAddressIndex.value == -1
                                  ? Colors.deepPurple
                                  : Colors.grey.shade400,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "GPS Location",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                locationController.originalLocation.value,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: locationController.selectedAddressIndex.value == -1
                                      ? Colors.deepPurple.shade700
                                      : Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 🔹 Saved Address Chips
                    ...locationController.savedAddresses.asMap().entries.map((entry) {
                      final index = entry.key;
                      final address = entry.value;
                      final isSelected =
                          locationController.selectedAddressIndex.value == index;

                      return GestureDetector(
                        onTap: () {
                          locationController.selectedAddressIndex.value = index;
                          locationController.location.value = address.address;
                          locationController.selectedPoint.value = address.coordinates;
                        },
                        onLongPress: () {
                          _showEditLabelDialog(context, index, locationController);
                        },
                        child: SizedBox(
                          width: chipWidth,
                          height: chipHeight,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                              isSelected ? Colors.deepPurple.shade100 : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: isSelected ? Colors.deepPurple : Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  address.label,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: isSelected ? Colors.deepPurple : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  address.address,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                    isSelected ? Colors.deepPurple.shade700 : Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              }),

              const SizedBox(height: 10),

              // Add Address Button
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.add_location_alt, color: Colors.black),
                title: const Text(
                  "Add New Address",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.addLocation);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return SliverAppBar(
      backgroundColor: AppColors.primary,
      floating: true,
      pinned: true,
      snap: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.white),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () => _showLocationBottomSheet(context),
            child: Obx(() => SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                locationController.location.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: AppColors.white),
          onPressed: () {
            Get.toNamed(AppRoutes.favorite);
          },
        ),


      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for restaurants and groceries",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}
