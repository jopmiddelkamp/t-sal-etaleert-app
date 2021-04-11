import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../routes.dart';
import 'common/bloc/barrel.dart';
import 'common/services/barrel.dart';
import 'common/utils/dialog_utils.dart';
import 'constants.dart';
import 'pages/intro/intro_page.dart';
import 'pages/speciality_preferences/bloc/barrel.dart';
import 'pages/speciality_preferences/speciality_preferences_page.dart';
import 'theme.dart';

final sl = GetIt.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return multiProviderWrapper(
      child: MaterialApp(
        title: '\'t Sal etaleert',
        theme: buildAppTheme(context),
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            if (state is AppAppInitializationError) {
              DialogUtils.showErrorDialog(
                context: context,
                title: 'Whoops!',
                message:
                    'Er is een fout opgetreden bij het laden van de app. Sluit de app en probeer het opnieuw. Blijf het fout gaan neem dan contact op met de eigenaar van de app.',
              );
            }
          },
          builder: (context, state) {
            if (state is AppInitializing) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AppInitialized && !state.introAccepted) {
              return IntroPage();
            }
            return BlocProvider(
              create: (context) => SpecialityPreferencesPageBloc(
                sl<SpecialityService>(),
              ),
              child: SpecialityPreferencesPage(),
            );
          },
        ),
        builder: BotToastInit(),
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        onGenerateRoute: onGenerateRoute,
        navigatorKey: Application.navigatorKey,
      ),
    );
  }

  Widget multiProviderWrapper({
    required Widget child,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(
            sl<SharedPreferencesService>(),
          ),
        ),
        BlocProvider(
          create: (context) {
            final bloc = PermissionsBloc(
              sl<SharedPreferencesService>(),
            );
            bloc.add(PermissionsCheck());
            return bloc;
          },
        ),
      ],
      child: child,
    );
  }
}
