import '../../models/artist_model.dart';
import '../../models/route_model.dart';

abstract class RouteGeneratorRepository {
  Future<RouteModel> generateRoute({
    required final ArtistModel artistToStartAt,
    required final Set<ArtistModel> artistsToVisit,
  });
}
