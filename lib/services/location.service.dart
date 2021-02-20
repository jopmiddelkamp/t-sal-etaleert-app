import 'package:geolocator/geolocator.dart';
import 'package:tsal_etaleert/common/models/location.dart';

class LocationService {
  Future<Location> getCurrentLocation() async {
    final location = Location.fromPosition(
      await Geolocator.getCurrentPosition(),
    );
    return location;
  }

  double distanceBetween(Location locationA, Location locationB) {
    return Geolocator.distanceBetween(
      locationA.latitude,
      locationA.longitude,
      locationB.latitude,
      locationB.longitude,
    );
  }
}
