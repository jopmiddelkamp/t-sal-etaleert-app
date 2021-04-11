import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension PositionExtensions on Position {
  LatLng toLatLng() {
    return LatLng(
      this.latitude,
      this.longitude,
    );
  }
}
