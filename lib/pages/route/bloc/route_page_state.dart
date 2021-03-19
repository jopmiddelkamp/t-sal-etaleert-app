import '../../../common/models/artist_model.dart';
import '../../../common/models/route_stop_model.dart';

abstract class RoutePageState {
  const RoutePageState() : super();

  @override
  String toString() => '${this.runtimeType} {}';
}

class RouteInitializing extends RoutePageState {}

class RouteUpdated extends RoutePageState {
  final List<RouteStopModel> stops;

  const RouteUpdated({
    this.stops = const [],
  });

  @override
  String toString() => '${this.runtimeType} { stops: ${stops.length} }';

  RouteUpdated copyWith({
    List<ArtistModel>? stops,
  }) {
    return RouteUpdated(
      stops: stops as List<RouteStopModel>? ?? this.stops,
    );
  }
}
