import '../common/models/route_model.dart';

abstract class RouteRepository {
  Future createRoute(
    RouteModel data,
  );

  Stream<RouteModel> getRoute(
    String id,
  );
}
