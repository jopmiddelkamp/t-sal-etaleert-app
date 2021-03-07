import 'package:equatable/equatable.dart';

import '../../../common/models/artist_model.dart';

abstract class RoutePageEvent extends Equatable {
  const RoutePageEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => '${this.runtimeType} {}';
}

class RouteOpenRoute extends RoutePageEvent {
  const RouteOpenRoute();
}

class RouteCreateRoute extends RoutePageEvent {
  final List<ArtistModel> artists;
  final String startingArtistId;

  const RouteCreateRoute({
    this.artists,
    this.startingArtistId,
  });

  ArtistModel get startingArtist {
    return artists.firstWhere((e) => e.id == startingArtistId);
  }

  @override
  String toString() =>
      '${this.runtimeType} { artistsCount: ${artists.length}, startingArtistId: $startingArtistId }';
}

class RouteScanQr extends RoutePageEvent {
  final String value;

  const RouteScanQr(
    this.value,
  );

  @override
  String toString() => '${this.runtimeType} { value: $value }';
}
