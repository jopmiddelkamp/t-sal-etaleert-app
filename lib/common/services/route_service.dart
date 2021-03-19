import 'package:platform_device_id/platform_device_id.dart';

import '../models/route_model.dart';
import '../models/route_stop_model.dart';
import '../repositories/route_repository.dart';
import 'service_base.dart';

class RouteService extends ServiceBase {
  final RouteRepository _routeRepository;

  const RouteService(
    this._routeRepository,
  );

  Future<void> createRoute(
    List<RouteStopModel> stops,
  ) async {
    final data = RouteModel(
      id: await PlatformDeviceId.getDeviceId,
      stops: stops,
    );
    await _routeRepository.createRoute(data);
  }

  Stream<RouteModel?> getRoute() async* {
    final platformDeviceId = await PlatformDeviceId.getDeviceId;
    yield* _routeRepository.getRoute(
      platformDeviceId!,
    );
  }
}
