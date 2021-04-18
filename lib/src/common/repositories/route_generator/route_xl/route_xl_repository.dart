import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../environment_variable.dart';
import '../../../models/artist_model.dart';
import '../../../models/route_stop_model.dart';
import '../../dio_repository_base.dart';
import '../route_generator_repository.dart';
import 'extensions/rx_tour_response_extensions.dart';
import 'interceptors/rx_auth_interceptor.dart';
import 'models/rx_location_model.dart';
import 'models/rx_tour_request_model.dart';
import 'models/rx_tour_response_model.dart';

class RouteXlRouteGeneratorRepository extends DioRepositoryBase
    implements RouteGeneratorRepository {
  RouteXlRouteGeneratorRepository({
    required EnvironmentVariables env,
    required Dio http,
  }) : super(
          http: http,
          baseUrl: env.routeXlBaseUrl,
        ) {
    http.interceptors.insert(
      0,
      RxAuthInterceptor(
        username: env.routeXlUsername,
        password: env.routeXlPassword,
      ),
    );
  }

  @override
  Future<List<RouteStopModel>> generateRouteStops({
    required final ArtistModel artistToStartAt,
    required final Set<ArtistModel> artistsToVisit,
  }) async {
    final requestUrl = getApiUrl('/tour');
    final requestBody = _getTourRequestModel(
      artistsToVisit: artistsToVisit,
      artistToStartAt: artistToStartAt,
    );
    final Response resp = await safeRequest(
      () => http.post(
        requestUrl,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: FormData.fromMap({
          'locations': JsonEncoder().convert(requestBody.locations),
        }),
        // data: 'locations=${JsonEncoder().convert(requestBody.locations)}',
        // queryParameters: {
        //   'locations': JsonEncoder().convert(requestBody.locations)
        // }),
      ),
    );
    final response = RxTourResponseModel.fromJson(resp.data);
    return response.toRouteStopModels(
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
    final locations = artists
        .asMap()
        .map<int, RxLocationModel>((i, e) {
          final isLast = i == artists.length - 1;
          return MapEntry(
            i,
            RxLocationModel(
              name: isLast ? "The last location" : e.profile.fullName,
              lat: e.location.latitude,
              lng: e.location.latitude,
            ),
          );
        })
        .values
        .toList();
    final data = RxTourRequestModel(
      locations: locations,
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
