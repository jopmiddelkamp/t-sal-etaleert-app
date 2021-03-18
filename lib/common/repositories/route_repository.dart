import '../models/route_model.dart';

abstract class RouteRepository {
  Future<void> createRoute(
    RouteModel data,
  );

  Stream<RouteModel> getRoute(
    String id,
  );
}
