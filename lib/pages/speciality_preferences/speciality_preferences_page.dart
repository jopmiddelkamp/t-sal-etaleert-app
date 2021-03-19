import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/extensions/barrel.dart';
import '../../common/services/speciality_service.dart';
import '../../common/widgets/buttons/tsal_primary_button.dart';
import '../../common/widgets/list_tiles/list_tile.dart';
import '../../common/widgets/loading_indicators/circle_loading_indicator.dart';
import '../select_startpoint/select_startpoint_page.dart';
import 'bloc/barrel.dart';

class SpecialityPreferencesPage extends StatelessWidget {
  static const String routeName = '/speciality-preferences';

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => SpecialityPreferencesPageBloc(
          context.provider<SpecialityService>(),
        ),
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
              child: BlocBuilder<SpecialityPreferencesPageBloc,
                  SpecialityPreferencesPageState>(
                builder: (context, state) {
                  return TSALPrimaryButton(
                    label: Text('Verder'),
                    onTap: _buildNextButtonOnTapCallback(
                      context: context,
                      state: state,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback? _buildNextButtonOnTapCallback({
    required BuildContext context,
    required SpecialityPreferencesPageState state,
  }) {
    if (state is! SpecialityPreferencesUpdated) {
      return null;
    }
    final updatedState = state;
    if (updatedState.selectedSpecialityIds.isNotEmpty != true) {
      return null;
    }
    return () => context.navigator.pushNamed(
          SelectStartpointPage.routeName,
          arguments: SelectStartpointPageArguments(
            selectedSpecialityIds: updatedState.selectedSpecialityIds,
          ),
        );
  }

  Widget _buildList(BuildContext context) {
    return BlocBuilder<SpecialityPreferencesPageBloc,
        SpecialityPreferencesPageState>(
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
                title: Text(category.name.getValue()!),
                onTap: () => context
                    .blocProvider<SpecialityPreferencesPageBloc>()
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
