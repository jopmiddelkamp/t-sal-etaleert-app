import 'package:geolocator/geolocator.dart';

import '../../../models/location_model.dart';
import '../../service_base.dart';
import '../location_service.dart';

class GlLocationServiceImpl extends ServiceBase implements LocationService {
  Future<LocationModel> getCurrentLocation() async {
    final location = LocationModel.fromPosition(
      await Geolocator.getCurrentPosition(),
    );
    return location;
  }
}
