import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../common/extensions/barrel.dart';
import '../../../common/services/location/location_service.dart';
import '../../../common/widgets/loading_indicators/circle_loading_indicator.dart';
import '../../pages/select_startpoint/widgets/select_artist_card.dart';
import '../../services/artist_service.dart';
import '../route/route_page.dart';
import 'bloc/barrel.dart';

final sl = GetIt.instance;

class SelectStartpointPage extends StatelessWidget {
  static const String routeName = '/route_planner/select-startpoint';

  const SelectStartpointPage._();

  static Widget blocProvider(
    SelectStartpointPageArguments arguments,
  ) {
    return BlocProvider(
      create: (context) => SelectStartpointPageBloc(
        artistService: sl<ArtistService>(),
        locationService: sl<LocationService>(),
        selectedSpecialityIds: arguments.selectedSpecialityIds,
      ),
      child: SelectStartpointPage._(),
    );
  }

  static MaterialPageRoute route(
    SelectStartpointPageArguments arguments,
  ) {
    return MaterialPageRoute(
      builder: (context) => SelectStartpointPage.blocProvider(
        arguments,
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocListener<SelectStartpointPageBloc, SelectStartpointPageState>(
      listenWhen: (_, current) {
        return current is SelectStartpointUpdated && current.hasSelectedArtist;
      },
      listener: (context, state) {
        final current = state as SelectStartpointUpdated;
        context.navigator.pushNamed(
          RoutePage.routeName,
          arguments: CreateRoutePageArguments(
            artists: current.artists,
            startingArtistId: current.selectedArtistId!,
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Beginpunt'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selecteer de kunstenaar bij wie u graag wilt beginnen.',
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SelectStartpointPageBloc,
                    SelectStartpointPageState>(
                  builder: (context, state) {
                    if (state is SelectStartpointInitializing) {
                      return TSALCircleLoadingIndicator();
                    }
                    if (state is SelectStartpointUpdated) {
                      return Column(
                        children: _buildArtistCards(state),
                      );
                    }
                    return Center(
                      child: Text(
                        'No specialities to display..',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildArtistCards(
    SelectStartpointUpdated state,
  ) {
    final result = <Widget>[];
    var first = true;
    state.artists.take(2).forEach((e) {
      if (first) {
        // Do something
        first = false;
      } else {
        result.add(
          SizedBox(height: 16),
        );
      }
      result.add(
        Expanded(
          child: SelectArtistCard(artist: e),
        ),
      );
    });
    return result;
  }
}

class SelectStartpointPageArguments {
  final List<String> selectedSpecialityIds;

  const SelectStartpointPageArguments({
    required this.selectedSpecialityIds,
  });
}
