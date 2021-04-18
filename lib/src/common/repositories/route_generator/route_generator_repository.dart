import 'package:tsal_etaleert/src/common/models/route_stop_model.dart';

import '../../models/artist_model.dart';

abstract class RouteGeneratorRepository {
  Future<List<RouteStopModel>> generateRouteStops({
    required final ArtistModel artistToStartAt,
    required final Set<ArtistModel> artistsToVisit,
  });
}
