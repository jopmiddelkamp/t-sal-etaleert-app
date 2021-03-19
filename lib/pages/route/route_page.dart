import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/extensions/barrel.dart';
import '../../common/models/artist_model.dart';
import '../../common/services/route_service.dart';
import '../../common/ui/font_weight.dart';
import '../../common/widgets/loading_indicators/circle_loading_indicator.dart';
import 'bloc/barrel.dart';

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
              routeService: context.provider<RouteService>(),
              artists: arguments.artists,
              startingArtistId: arguments.startingArtistId,
            );
          }
          return RoutePageBloc.openRoute(
            routeService: context.provider<RouteService>(),
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
                      child: Center(
                        child: Text('Mock for map component'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          itemCount: state.stops.length,
                          itemBuilder: (context, index) {
                            final stop = state.stops[index];
                            return Row(
                              children: [
                                _getRouteIndicator(
                                  context,
                                  count: state.stops.length,
                                  index: index,
                                  active: index == 0,
                                ),
                                const SizedBox(width: 8),
                                Text(stop.artist.profile.fullName),
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
