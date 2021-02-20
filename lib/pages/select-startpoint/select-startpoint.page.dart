import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsal_etaleert/pages/home/home-page.dart';
import 'package:tsal_etaleert/pages/select-startpoint/widgets/select-artist-card.widget.dart';
import 'package:tsal_etaleert/services/location.service.dart';
import 'package:tsal_etaleert/widgets/loading-indicators/circle-loading-indicator.dart';

import '../../common/extensions/barrel.dart';
import '../../repositories/artist-repository.dart';
import '../speciality-preferences/bloc/barrel.dart';
import 'bloc/barrel.dart';

class SelectStartpointPage extends StatelessWidget {
  static const String routeName = '/select-startpoint';

  final SelectStartpointPageArguments arguments;

  const SelectStartpointPage({
    Key key,
    this.arguments,
  }) : super(key: key);

  static MaterialPageRoute route(
    SelectStartpointPageArguments arguments,
  ) {
    return MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SelectStartpointBloc(
              context.provider<ArtistRepository>(),
              context.provider<LocationService>(),
              arguments.specialityPreferencesBloc,
            ),
          )
        ],
        child: SelectStartpointPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beginpunt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Selecteer de kunstenaar bij wie u graag wilt beginnen.'),
            const SizedBox(height: 16),
            Expanded(
              child: BlocConsumer<SelectStartpointBloc, SelectStartpointState>(
                listener: (context, state) {
                  if (state is SelectStartpointUpdated &&
                      state.selectedArtistId != null) {
                    context.navigator.pushNamed(HomePage.routeName);
                  }
                },
                builder: (context, state) {
                  if (state is SelectStartpointInitializing) {
                    return TSALCircleLoadingIndicator();
                  }
                  if (state is SelectStartpointUpdated) {
                    return Column(
                      children: _buildArtistCards(state),
                    );
                  }
                  return Center(child: Text('No specialities to display..'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildArtistCards(SelectStartpointUpdated state) {
    final result = List<Widget>();
    var first = true;
    state.artists.forEach((e) {
      if (first) {
        // Do something
        first = false;
      } else {
        result.add(SizedBox(height: 16));
      }
      result.add(Expanded(
        child: SelectArtistCard(artist: e),
      ));
    });
    return result;
  }
}

class SelectStartpointPageArguments {
  final SpecialityPreferencesBloc specialityPreferencesBloc;

  const SelectStartpointPageArguments({
    this.specialityPreferencesBloc,
  });
}
