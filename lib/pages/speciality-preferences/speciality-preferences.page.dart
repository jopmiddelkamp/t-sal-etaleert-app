import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsal_etaleert/pages/select-startpoint/select-startpoint.page.dart';

import '../../common/extensions/barrel.dart';
import '../../widgets/loading-indicators/circle-loading-indicator.dart';
import '../../widgets/list-tiles/list-tile.dart';
import '../../widgets/buttons/tsal-primary-button.dart';
import '../../repositories/speciality-repository.dart';
import 'bloc/barrel.dart';

class SpecialityPreferencesPage extends StatelessWidget {
  static const String routeName = '/speciality-preferences';

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) =>
            SpecialityPreferencesBloc(context.provider<SpecialityRepository>()),
        child: SpecialityPreferencesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interesses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Maak hier uw selectie:'),
            const SizedBox(height: 16),
            Expanded(
              child: _buildList(context),
            ),
            const SizedBox(height: 16),
            const Divider(height: 2),
            Container(
              width: double.infinity,
              child: BlocBuilder<SpecialityPreferencesBloc,
                  SpecialityPreferencesState>(
                builder: (context, state) {
                  final enabled = state is SpecialityPreferencesUpdated &&
                      state.selectedSpecialityIds?.isNotEmpty == true;
                  return TSALPrimaryButton(
                    label: Text('Verder'),
                    onTap: enabled
                        ? () => context.navigator.pushNamed(
                              SelectStartpointPage.routeName,
                              arguments: SelectStartpointPageArguments(
                                specialityPreferencesBloc: context
                                    .blocProvider<SpecialityPreferencesBloc>(),
                              ),
                            )
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return BlocBuilder<SpecialityPreferencesBloc, SpecialityPreferencesState>(
      builder: (context, state) {
        if (state is SpecialityPreferencesInitializing) {
          return TSALCircleLoadingIndicator();
        }
        if (state is SpecialityPreferencesUpdated) {
          return ListView.builder(
            itemCount: state.specialities.length,
            itemBuilder: (context, index) {
              final category = state.specialities[index];
              return TSALListTile(
                title: Text(category.name.getValue()),
                onTap: () => context
                    .blocProvider<SpecialityPreferencesBloc>()
                    .add(SpecialityPreferencesToggleSpeciality(category)),
                selected: state.selectedSpecialityIds.contains(category.id),
              );
            },
          );
        }
        return Center(child: Text('No specialities to display..'));
      },
    );
  }
}
