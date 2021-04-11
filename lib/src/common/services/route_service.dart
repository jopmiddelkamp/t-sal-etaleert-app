import 'package:platform_device_id/platform_device_id.dart';

import '../models/route_model.dart';
import '../models/route_stop_model.dart';
import '../repositories/route/route_repository.dart';
import '../repositories/route_generator/route_generator_repository.dart';
import 'service_base.dart';

abstract class RouteService {
  Future<void> createRoute(
    List<RouteStopModel> stops,
  );
  Stream<RouteModel?> getRoute();
}

class RouteServiceImpl extends ServiceBase implements RouteService {
  final RouteRepository _routeRepository;
  final RouteGeneratorRepository _routeGeneratorRepository;

  const RouteServiceImpl({
    required final RouteRepository routeRepository,
    required final RouteGeneratorRepository routeGeneratorRepository,
  })   : _routeRepository = routeRepository,
        _routeGeneratorRepository = routeGeneratorRepository;

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
