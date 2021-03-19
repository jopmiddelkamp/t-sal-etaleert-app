import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/models/artist_model.dart';
import '../../../common/models/route_stop_model.dart';
import '../../../common/services/route_service.dart';
import 'barrel.dart';

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
    add(RouteOpenRoute());
  }

  @override
  Stream<RoutePageState> mapEventToState(
    RoutePageEvent event,
  ) async* {
    if (event is RouteCreateRoute) {
      yield* _onCreateRoute(event);
    } else if (event is RouteOpenRoute) {
      yield* _onOpenRoute(event);
    } else if (event is RouteUpdateRoute) {
      yield* _onUpdateRoute(event);
    } else if (event is RouteScanQr) {
      yield* _onQrScanned(event);
    } else {
      print('${this.runtimeType}: unsupported event!');
    }
  }

  Stream<RoutePageState> _onCreateRoute(
    RouteCreateRoute event,
  ) async* {
    _routeStreamSub?.cancel();
    await _routeService.createRoute([
      RouteStopModel(
        artist: event.startingArtist,
      ),
      ...event.artists.where((e) {
        return e.id != event.startingArtistId;
      }).map((e) {
        return RouteStopModel(
          artist: e,
        );
      }).toList(growable: false),
    ]);
    add(RouteOpenRoute());
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
      final event = RouteUpdateRoute(
        route,
      );
      add(event);
    });
  }

  Stream<RoutePageState> _onUpdateRoute(
    RouteUpdateRoute event,
  ) async* {
    final state = RouteUpdated(
      stops: event.route.stops,
    );
    yield state;
  }

  Stream<RoutePageState> _onQrScanned(
    RouteScanQr event,
  ) async* {}

  @override
  Future<void> close() {
    _routeStreamSub?.cancel();
    return super.close();
  }
}
