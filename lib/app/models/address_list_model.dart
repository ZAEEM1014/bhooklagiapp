import 'package:latlong2/latlong.dart';

class SavedAddress {
  final String label;
  final String address;
  final LatLng coordinates;

  SavedAddress({
    required this.label,
    required this.address,
    required this.coordinates,
  });

  SavedAddress copyWith({
    String? label,
    String? address,
    LatLng? coordinates,
  }) {
    return SavedAddress(
      label: label ?? this.label,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
