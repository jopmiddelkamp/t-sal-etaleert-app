import 'package:platform_device_id/platform_device_id.dart';
import 'package:tsal_etaleert/common/models/route_stop_model.dart';

import '../common/models/route_model.dart';
import '../repositories/route_repository.dart';
import 'service_base.dart';

class RouteService extends ServiceBase {
  final RouteRepository _routeRepository;

  const RouteService(
    this._routeRepository,
  );

  Future createRoute(
    List<RouteStopModel> stops,
  ) async {
    await _routeRepository.createRoute(
      RouteModel(
        id: await PlatformDeviceId.getDeviceId,
        stops: stops,
      ),
    );
  }

  Stream<RouteModel> getRoute() async* {
    yield* _routeRepository.getRoute(
      await PlatformDeviceId.getDeviceId,
    );
  }
}
