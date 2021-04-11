import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/location_model.dart';

extension LocationModelExtensions on LocationModel {
  LatLng toLatLng() {
    return LatLng(
      this.latitude,
      this.longitude,
    );
  }
}
