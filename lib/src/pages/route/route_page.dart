import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/extensions/barrel.dart';
import '../../common/models/artist_model.dart';
import '../../common/models/route_stop_model.dart';
import '../../common/services/route_service.dart';
import '../../common/ui/font_weight.dart';
import '../../common/utils/image_utils.dart';
import '../../common/utils/marker_utils.dart';
import '../../common/widgets/loading_indicators/circle_loading_indicator.dart';
import '../../constants.dart';
import 'bloc/barrel.dart';

final sl = GetIt.instance;

class RoutePage extends StatelessWidget {
  static const String routeName = '/route';

  const RoutePage({
    Key? key,
  }) : super(key: key);

  static MaterialPageRoute route(
    RoutePageArguments arguments,
  ) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<RoutePageBloc>(
        create: (context) {
          if (arguments is CreateRoutePageArguments) {
            return RoutePageBloc.createRoute(
              routeService: sl<RouteService>(),
              artists: arguments.artists,
              startingArtistId: arguments.startingArtistId,
            );
          }
          return RoutePageBloc.openRoute(
            routeService: sl<RouteService>(),
          );
        },
        child: RoutePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoutePageBloc, RoutePageState>(
      listener: (context, state) {
        print(state.runtimeType);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Route'),
        ),
        body: BlocBuilder<RoutePageBloc, RoutePageState>(
          builder: (context, currentState) {
            if (currentState is! RouteUpdated) {
              return TSALCircleLoadingIndicator();
            }
            final state = currentState;
            return LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight / 3,
                      color: Colors.grey.shade100,
                      child: FutureBuilder<Set<Marker>>(
                          future: _generateMarkers(
                            context,
                            stops: state.stops,
                            currentStop: state.currentStop,
                          ),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: TSALCircleLoadingIndicator(),
                              );
                            }
                            return GoogleMap(
                              myLocationEnabled: true,
                              compassEnabled: true,
                              initialCameraPosition: Application.defaultSettings
                                  .getGoogleMapsCameraPosition(
                                state.initialMapLatLng,
                              ),
                              onMapCreated: (controller) {
                                final event = MapControllerCreated(controller);
                                context
                                    .blocProvider<RoutePageBloc>()
                                    .add(event);
                              },
                              markers: snapshot.data!,
                            );
                          }),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          itemCount: state.stops.length,
                          itemBuilder: (context, index) {
                            final stop = state.stops[index];
                            final isActiveStop = state.currentStop == stop;
                            return Row(
                              children: [
                                _getRouteIndicator(
                                  context,
                                  count: state.stops.length,
                                  index: index,
                                  active: index == 0,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  stop.artist.profile.fullName,
                                  style: isActiveStop
                                      ? TextStyle(
                                          fontWeight: TSALFontWeight.bold,
                                        )
                                      : null,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<Set<Marker>> _generateMarkers(
    BuildContext context, {
    required List<RouteStopModel> stops,
    required RouteStopModel currentStop,
  }) async {
    final markers = await Future.wait(stops.map(
      (e) => _buildMarker(
        context,
        artist: e.artist,
        current: e.artist == currentStop.artist,
      ),
    ));
    return markers.toSet();
  }

  Future<Marker> _buildMarker(
    BuildContext context, {
    required ArtistModel artist,
    required bool current,
  }) async {
    final size = const Size(200, 200);
    final shadowColor = current
        ? context.theme.colorScheme.primary
        : context.theme.colorScheme.secondary;
    return Marker(
      markerId: MarkerId(artist.id ?? artist.profile.fullName),
      icon: await MarkerUtils.getMarkerIcon(
        imageResolver: () async => artist.profile.hasPersonalImage
            ? ImageUtils.getUiImageFromUrl(
                artist.profile.personalImage!,
              )
            : ImageUtils.getUiImageFromAsset(
                Application.defaultSettings.artistFallbackImagePath,
              ),
        size: size,
        shadowColor: shadowColor,
      ),
      position: artist.location.toLatLng(),
    );
  }

  Widget _getRouteIndicator(
    BuildContext context, {
    required int count,
    required int index,
    required bool active,
  }) {
    final dark = context.theme.colorScheme.secondary;
    final light = context.theme.colorScheme.secondaryVariant;

    const width = 32.0;
    return SizedBox(
      width: width,
      height: width * 2,
      child: Stack(
        children: [
          if (index > 0)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: width * 0.75,
                child: Center(
                  child: Container(
                    height: double.infinity,
                    width: width / 8,
                    color: light,
                  ),
                ),
              ),
            ),
          if (index < count - 1)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: width * 0.75,
                child: Center(
                  child: Container(
                    height: double.infinity,
                    width: width / 8,
                    color: light,
                  ),
                ),
              ),
            ),
          Center(
            child: Transform.scale(
              scale: active ? 1 : 0.85,
              child: CircleAvatar(
                radius: width / 2,
                backgroundColor: active ? dark : light,
                foregroundColor: context.theme.colorScheme.onSecondary,
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: context.textTheme.bodyText2!.copyWith(
                      color: context.theme.colorScheme.onPrimary,
                      fontSize: width / 1.75,
                      fontWeight: TSALFontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

abstract class RoutePageArguments {
  const RoutePageArguments();
}

class CreateRoutePageArguments extends RoutePageArguments {
  final List<ArtistModel> artists;
  final String startingArtistId;

  const CreateRoutePageArguments({
    required this.artists,
    required this.startingArtistId,
  });
}

class OpenExistingRoutePageArguments extends RoutePageArguments {
  const OpenExistingRoutePageArguments();
}

// class ArtistMarker extends Marker {
//   ArtistMarker({
//     required this.markerId,
//   }) : super(markerId: markerId);

// }
