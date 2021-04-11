import 'package:geolocator/geolocator.dart';

import '../models/location_model.dart';
import 'service_base.dart';

abstract class LocationService {
  Future<LocationModel> getCurrentLocation();
}

class LocationServiceImpl extends ServiceBase implements LocationService {
  Future<LocationModel> getCurrentLocation() async {
    final location = LocationModel.fromPosition(
      await Geolocator.getCurrentPosition(),
    );
    return location;
  }
}
