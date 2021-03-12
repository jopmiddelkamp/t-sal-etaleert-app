import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/route_model.dart';
import '../route_repository.dart';

class FirestoreRouteRepository implements RouteRepository {
  final CollectionReference _routeCollection;

  FirestoreRouteRepository()
      : _routeCollection = FirebaseFirestore.instance.collection('routes');

  @override
  Future createRoute(
    RouteModel data,
  ) async {
    await _routeCollection.doc(data.id).set(data.toJson());
  }

  @override
  Stream<RouteModel> getRoute(
    String id,
  ) async* {
    yield* _routeCollection.doc(id).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }
      return RouteModel.fromMap(
        snapshot.id,
        snapshot.data(),
      );
    });
  }
}
