import '../../models/location_model.dart';

abstract class LocationService {
  Future<LocationModel> getCurrentLocation();
}
