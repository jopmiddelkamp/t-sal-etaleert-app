import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/loading-indicators/circle-loading-indicator.dart';
import '../../../common/extensions/barrel.dart';
import '../../home/home-page.dart';
import '../bloc/barrel.dart';
import 'select-artist-card.widget.dart';

class SelectArtistList extends StatelessWidget {
  const SelectArtistList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectStartpointBloc, SelectStartpointState>(
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
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: state.artists.length,
            itemBuilder: (context, index) {
              final artist = state.artists[index];
              return SelectArtistCard(artist: artist);
            },
          );
        }
        return Center(child: Text('No specialities to display..'));
      },
    );
  }
}
