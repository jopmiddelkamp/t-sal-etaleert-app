import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/artist_model.dart';
import '../../../models/route_stop_model.dart';

abstract class RoutePageEvent extends Equatable {
  const RoutePageEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => '${this.runtimeType} {}';
}

class RouteOpenRoute extends RoutePageEvent {
  final LatLng initialMapLatLng;

  const RouteOpenRoute({
    required this.initialMapLatLng,
  });
}

class RouteLoadRoute extends RoutePageEvent {
  final List<RouteStopModel> stops;
  final RouteStopModel currentStop;
  final LatLng initialMapLatLng;

  const RouteLoadRoute({
    required this.stops,
    required this.currentStop,
    required this.initialMapLatLng,
  });
}

class RouteUpdateRoute extends RoutePageEvent {
  final List<RouteStopModel> stops;
  final RouteStopModel currentStop;

  const RouteUpdateRoute({
    required this.stops,
    required this.currentStop,
  });
}

class RouteCreateRoute extends RoutePageEvent {
  final List<ArtistModel> artists;
  final String startingArtistId;

  const RouteCreateRoute({
    required this.artists,
    required this.startingArtistId,
  });

  ArtistModel get startingArtist {
    return artists.firstWhere((e) => e.id == startingArtistId);
  }

  @override
  String toString() =>
      '${this.runtimeType} { artistsCount: ${artists.length}, startingArtistId: $startingArtistId }';
}

class QrScanned extends RoutePageEvent {
  final String value;

  const QrScanned(
    this.value,
  );

  @override
  String toString() => '${this.runtimeType} { value: $value }';
}

class MapControllerCreated extends RoutePageEvent {
  final GoogleMapController controller;

  const MapControllerCreated(
    this.controller,
  );

  @override
  String toString() => '${this.runtimeType} { controller: $controller }';
}

class RouteCompleteRoute extends RoutePageEvent {
  final List<RouteStopModel> stops;

  const RouteCompleteRoute({
    required this.stops,
  });
}
