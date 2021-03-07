import 'package:geolocator/geolocator.dart';

import '../common/models/location_model.dart';
import 'service_base.dart';

class LocationService extends ServiceBase {
  Future<LocationModel> getCurrentLocation() async {
    final location = LocationModel.fromPosition(
      await Geolocator.getCurrentPosition(),
    );
    return location;
  }
}
