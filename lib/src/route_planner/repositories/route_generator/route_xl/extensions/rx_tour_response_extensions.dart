import '../../../../../common/extensions/iterable_extensions.dart';
import '../../../../models/artist_model.dart';
import '../../../../models/route_stop_model.dart';
import '../models/rx_tour_response_model.dart';

extension RxTourResponseExtensions on RxTourResponseModel {
  List<RouteStopModel> toRouteStopModels({
    required final Set<ArtistModel> artistsToVisit,
  }) {
    // Skip the last as it's the same as the first
    final routeSteps = this.route.values.skipLast();
    final artistLookup = artistsToVisit.toLookupMap(
      (e) => e.profile.fullName,
    );
    final artists = routeSteps.map<ArtistModel>((e) => artistLookup[e.name]!);
    return _getRouteStopModels(
      artists: artists,
    );
  }

  List<RouteStopModel> _getRouteStopModels({
    required Iterable<ArtistModel> artists,
  }) {
    return artists.map<RouteStopModel>((e) {
      return RouteStopModel(artist: e);
    }).toList();
  }
}
