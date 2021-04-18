import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../routes.dart';
import 'common/bloc/barrel.dart';
import 'common/dialogs/error_dialog.dart';
import 'common/services/barrel.dart';
import 'constants.dart';
import 'intro/intro_page.dart';
import 'route_planner/pages/speciality_preferences/speciality_preferences_page.dart';
import 'theme.dart';

final sl = GetIt.instance;

class MyApp extends StatelessWidget {
  MyApp._();

  static Widget blocProvider() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(
            persistentStorageService: sl<PersistentStorageService>(),
          ),
        ),
      ],
      child: MyApp._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '\'t Sal etaleert',
      theme: buildAppTheme(context),
      home: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppAppInitializationError) {
            showErrorDialog(
              context,
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
            return IntroPage.blocProvider();
          }
          return SpecialityPreferencesPage.blocProvider();
        },
      ),
      builder: BotToastInit(),
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      onGenerateRoute: onGenerateRoute,
      navigatorKey: Application.navigatorKey,
    );
  }
}
