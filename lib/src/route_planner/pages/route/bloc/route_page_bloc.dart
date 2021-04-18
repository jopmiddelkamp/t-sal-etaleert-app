import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../common/extensions/position_extensions.dart';
import '../../../models/artist_model.dart';
import '../../../services/route_service.dart';
import 'barrel.dart';

final gl = GeolocatorPlatform.instance;

class RoutePageBloc extends Bloc<RoutePageEvent, RoutePageState> {
  final RouteService _routeService;

  StreamSubscription? _routeStreamSub;

  RoutePageBloc.createRoute({
    required RouteService routeService,
    required List<ArtistModel> artists,
    required String startingArtistId,
  })   : _routeService = routeService,
        super(RouteInitializing()) {
    add(RouteCreateRoute(
      artists: artists,
      startingArtistId: startingArtistId,
    ));
  }

  RoutePageBloc.openRoute({
    required RouteService routeService,
  })   : _routeService = routeService,
        super(RouteInitializing()) {
    _openRoute();
  }

  Future<void> _openRoute() async {
    // TODO: add retry mechanism
    try {
      // extract to loosly coupled service/repo
      final lastPos = await gl.getLastKnownPosition();
      if (lastPos != null) {
        add(RouteOpenRoute(
          initialMapLatLng: lastPos.toLatLng(),
        ));
      }
    } on PermissionDeniedException {
      // ask one more time
    }
  }

  @override
  Stream<RoutePageState> mapEventToState(
    RoutePageEvent event,
  ) async* {
    if (event is RouteCreateRoute) {
      yield* _onCreateRoute(event);
    } else if (event is RouteOpenRoute) {
      yield* _onOpenRoute(event);
    } else if (event is RouteLoadRoute) {
      yield* _onLoadRoute(event);
    } else if (event is RouteUpdateRoute) {
      yield* _onUpdateRoute(event);
    } else if (event is RouteCompleteRoute) {
      yield* _onCompleteRoute(event);
    } else if (event is QrScanned) {
      yield* _onQrScanned(event);
    } else if (event is MapControllerCreated) {
      yield* _onMapControllerCreated(event);
    } else {
      print('${this.runtimeType}: unsupported event!');
    }
  }

  Stream<RoutePageState> _onCreateRoute(
    RouteCreateRoute event,
  ) async* {
    _routeStreamSub?.cancel();
    await _routeService.createRoute(
      artists: event.artists.toSet(),
      artistToStartAt: event.startingArtist,
    );
    await _openRoute();
  }

  Stream<RoutePageState> _onOpenRoute(
    RouteOpenRoute event,
  ) async* {
    _routeStreamSub?.cancel();
    _routeStreamSub = _routeService.getRoute().listen((route) {
      if (route == null) {
        // TODO: handle situation
        return;
      }
      if (route.stops.every((e) => e.completed)) {
        add(RouteCompleteRoute(
          stops: route.stops,
        ));
      } else {
        if (state is RouteInitializing) {
          add(RouteLoadRoute(
            stops: route.stops,
            currentStop: route.stops.firstWhere((e) => !e.completed),
            initialMapLatLng: event.initialMapLatLng,
          ));
        } else {
          add(RouteUpdateRoute(
            stops: route.stops,
            currentStop: route.stops.firstWhere((e) => !e.completed),
          ));
        }
      }
    });
  }

  Stream<RoutePageState> _onLoadRoute(
    RouteLoadRoute event,
  ) async* {
    yield RouteUpdated(
      stops: event.stops,
      currentStop: event.currentStop,
      initialMapLatLng: event.initialMapLatLng,
    );
  }

  Stream<RoutePageState> _onUpdateRoute(
    RouteUpdateRoute event,
  ) async* {
    if (state is RouteUpdated) {
      yield (state as RouteUpdated).copyWith(
        stops: event.stops,
        currentStop: event.currentStop,
      );
    }
  }

  Stream<RoutePageState> _onCompleteRoute(
    RouteCompleteRoute event,
  ) async* {
    yield RouteCompleted(
      stops: event.stops,
    );
  }

  Stream<RoutePageState> _onQrScanned(
    QrScanned event,
  ) async* {}

  Stream<RoutePageState> _onMapControllerCreated(
    MapControllerCreated event,
  ) async* {
    if (state is RouteUpdated) {
      yield (state as RouteUpdated).copyWith(
        mapController: event.controller,
      );
    }
  }

  @override
  Future<void> close() {
    _routeStreamSub?.cancel();
    return super.close();
  }
}
