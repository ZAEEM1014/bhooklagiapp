import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/address_list_model.dart';

class LocationController extends GetxController {
  /// Observables
  final location = 'Fetching location...'.obs;
  final originalLocation = ''.obs;
  final selectedPoint = const LatLng(33.6844, 73.0479).obs; // Default Islamabad
  final savedAddresses = <SavedAddress>[].obs;
  final selectedAddressIndex = 0.obs;

  /// Controller for address field
  final TextEditingController addressController = TextEditingController();

  /// 🔹 Fetch current location using GPS
  Future<void> fetchCurrentLocation() async {
    if (!await _handleLocationPermission()) {
      Get.snackbar('Permission Denied', 'Location access is required.');
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await updateLocationFromCoordinates(position.latitude, position.longitude);

      // Store the original location once
      if (originalLocation.value.isEmpty) {
        originalLocation.value = location.value;
      }
    } catch (e) {
      location.value = "Failed to fetch current location.";
    }
  }

  /// 🔹 Update address and map from coordinates
  Future<void> updateLocationFromCoordinates(double lat, double lng) async {
    selectedPoint.value = LatLng(lat, lng);

    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final addressParts = [
          place.name,

          place.subLocality,
          place.locality,

        ];

        final newAddress = addressParts
            .whereType<String>()
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .join(', ');

        location.value = newAddress;
        addressController.text = newAddress;
      } else {
        location.value = "Unknown location";
        addressController.clear();
      }
    } catch (e) {
      location.value = "Failed to fetch address.";
      addressController.clear();
    }
  }

  /// 🔹 Save a new address or update existing
  void saveOrUpdateAddress(String label) {
    final newAddress = SavedAddress(
      label: label,
      address: location.value,
      coordinates: selectedPoint.value,
    );

    final index = savedAddresses.indexWhere(
          (addr) => addr.address.toLowerCase() == newAddress.address.toLowerCase(),
    );

    if (index != -1) {
      savedAddresses[index] = newAddress;
      selectedAddressIndex.value = index;
    } else {
      savedAddresses.add(newAddress);
      selectedAddressIndex.value = savedAddresses.length - 1;
    }

    Get.back();
  }

  /// 🔹 User taps on saved address chip
  void selectSavedAddress(int index) {
    if (index < 0 || index >= savedAddresses.length) return;

    final selected = savedAddresses[index];
    selectedPoint.value = selected.coordinates;
    location.value = selected.address;
    addressController.text = selected.address;
    selectedAddressIndex.value = index;
  }

  /// 🔹 Handle marker drag or tap on map
  Future<void> onMapMarkerMoved(LatLng latLng) async {
    await updateLocationFromCoordinates(latLng.latitude, latLng.longitude);
  }

  /// 🔹 Search location by address string
  Future<void> searchLocation(String query) async {
    try {
      final locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        await updateLocationFromCoordinates(loc.latitude, loc.longitude);
      } else {
        Get.snackbar('Not Found', 'Could not find the location.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to search location.');
    }
  }

  /// 🔹 Handle location permissions
  Future<bool> _handleLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Location Disabled', 'Please enable location services.');
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Permission Denied', 'Enable location from settings.');
      return false;
    }

    return true;
  }
}
