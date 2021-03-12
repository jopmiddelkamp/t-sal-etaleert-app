import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/extensions/barrel.dart';
import '../../common/models/artist_model.dart';
import '../../common/services/route_service.dart';
import '../../common/widgets/loading_indicators/circle_loading_indicator.dart';
import 'bloc/barrel.dart';

class RoutePage extends StatelessWidget {
  static const String routeName = '/route';

  final RoutePageArguments arguments;

  const RoutePage({
    Key key,
    this.arguments,
  }) : super(key: key);

  static MaterialPageRoute route(
    RoutePageArguments arguments,
  ) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) {
          if (arguments is CreateRoutePageArguments) {
            return RoutePageBloc.createRoute(
              routeService: context.provider<RouteService>(),
              artists: arguments.artists,
              startingArtistId: arguments.startingArtistId,
            );
          } else if (arguments is OpenExistingRoutePageArguments) {
            return RoutePageBloc.openRoute(
              routeService: context.provider<RouteService>(),
            );
          }
          // alert message
          Navigator.of(context).pop();
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
          builder: (context, state) {
            if (state is RouteInitializing) {
              return TSALCircleLoadingIndicator();
            }
            return Container(
              child: Center(
                child: Text('Jop test'),
              ),
            );
          },
        ),
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
    @required this.artists,
    @required this.startingArtistId,
  });
}

class OpenExistingRoutePageArguments extends RoutePageArguments {
  const OpenExistingRoutePageArguments();
}
