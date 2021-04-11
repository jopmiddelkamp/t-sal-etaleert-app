import 'package:dio/dio.dart';

import '../../../models/artist_model.dart';
import '../../../models/route_model.dart';
import '../../dio_repository_base.dart';
import '../route_generator_repository.dart';
import 'extensions/rx_tour_response_extensions.dart';
import 'models/rx_location_model.dart';
import 'models/rx_tour_request_model.dart';
import 'models/rx_tour_response_model.dart';

class RouteXlRouteGeneratorRepository extends DioRepositoryBase
    implements RouteGeneratorRepository {
  RouteXlRouteGeneratorRepository({
    required Dio http,
    required String baseUrl,
  }) : super(
          http: http,
          baseUrl: baseUrl,
        );

  @override
  Future<RouteModel> generateRoute({
    required final ArtistModel artistToStartAt,
    required final Set<ArtistModel> artistsToVisit,
  }) async {
    final Response resp = await safeRequest(
      () => http.post(
        getApiUrl('/tour'),
        data: _getTourRequestModel(
          artistsToVisit: artistsToVisit,
          artistToStartAt: artistToStartAt,
        ),
      ),
    );
    final response = RxTourResponseModel.fromJson(resp.data);
    return response.toRouteModel(
      artistsToVisit: artistsToVisit,
    );
  }

  RxTourRequestModel _getTourRequestModel({
    required Set<ArtistModel> artistsToVisit,
    required ArtistModel artistToStartAt,
  }) {
    final artists = _getArtistsListForRouteGeneration(
      artistsToVisit: artistsToVisit,
      artistToStartAt: artistToStartAt,
    );
    final data = RxTourRequestModel(
      locations: artists.map((e) {
        return RxLocationModel(
          address: e.profile.fullName,
          latitude: e.location.latitude,
          longitude: e.location.latitude,
        );
      }).toList(),
    );
    return data;
  }

  List<ArtistModel> _getArtistsListForRouteGeneration({
    required final Set<ArtistModel> artistsToVisit,
    required final ArtistModel artistToStartAt,
  }) {
    List<ArtistModel> result = artistsToVisit.toList();
    result.remove(artistToStartAt);
    // First element is start location
    result.insert(0, artistToStartAt);
    result = result.take(8).toList();
    // Last element is finish location
    result.add(artistToStartAt);
    return result;
  }
}
