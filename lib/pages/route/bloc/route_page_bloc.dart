import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsal_etaleert/common/models/route_stop_model.dart';
import 'package:tsal_etaleert/services/route_service.dart';

import '../../../common/models/artist_model.dart';
import 'barrel.dart';

class RoutePageBloc extends Bloc<RoutePageEvent, RoutePageState> {
  final RouteService _routeService;

  StreamSubscription _specialitiesStreamSub;
  StreamSubscription _artistsStreamSub;

  RoutePageBloc.createRoute({
    RouteService routeService,
    List<ArtistModel> artists,
    String startingArtistId,
  })  : assert(routeService != null),
        assert(artists != null),
        assert(startingArtistId != null),
        _routeService = routeService,
        super(RouteInitializing()) {
    add(RouteCreateRoute(
      artists: artists,
      startingArtistId: startingArtistId,
    ));
  }

  RoutePageBloc.openRoute({
    RouteService routeService,
  })  : assert(routeService != null),
        _routeService = routeService,
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
      yield* _onOpenRoute();
    } else if (event is RouteScanQr) {
      yield* _onQrScanned(event);
    } else {
      print('${this.runtimeType}: unsupported event!');
    }
  }

  Stream<RoutePageState> _onCreateRoute(
    RouteCreateRoute event,
  ) async* {
    await _routeService.createRoute([
      RouteStopModel(
        artist: event.startingArtist,
      ),
      ...event.artists.where((e) {
        return e.id != event.startingArtistId;
      }).map((e) {
        return RouteStopModel(artist: e);
      }).toList(growable: false),
    ]);
    add(RouteOpenRoute());
  }

  Stream<RoutePageState> _onOpenRoute() async* {}

  Stream<RoutePageState> _onQrScanned(
    RouteScanQr event,
  ) async* {}

  @override
  Future close() {
    _specialitiesStreamSub?.cancel();
    _artistsStreamSub?.cancel();
    return super.close();
  }
}
