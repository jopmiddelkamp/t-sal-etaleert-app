import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tsal_etaleert/services/location.service.dart';

import 'bloc/barrel.dart';
import 'common/utils/dialog-utils.dart';
import 'common/extensions/build-context.extensions.dart';
import 'pages/intro/intro-page.dart';
import 'pages/speciality-preferences/bloc/barrel.dart';
import 'pages/speciality-preferences/speciality-preferences.page.dart';
import 'repositories/artist-repository.dart';
import 'repositories/speciality-repository.dart';
import 'repositories/firestore/firestore-artist-repository.dart';
import 'repositories/firestore/firestore-speciality-repository.dart';
import 'services/shared-preferences.service.dart';
import 'theme.dart';
import 'routes.dart';
import 'constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        Provider<SpecialityRepository>(
          create: (_) => FirestoreSpecialityRepository(),
        ),
        Provider<LocationService>(
          create: (_) => LocationService(),
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider<ArtistRepository>(
            create: (context) => FirestoreArtistRepository(
              context.provider<SpecialityRepository>(),
            ),
          ),
          Provider<SharedPreferencesService>(
            create: (_) => SharedPreferencesService(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppBloc(
                context.provider<SharedPreferencesService>(),
              ),
            ),
            BlocProvider(
              create: (context) => PermissionsBloc(
                context.provider<SharedPreferencesService>(),
              ),
            ),
          ],
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            return Center(child: CircularProgressIndicator());
          }
          if (state is AppInitialized && !state.introAccepted) {
            return IntroPage();
          }
          return BlocProvider(
            create: (context) => SpecialityPreferencesBloc(
                context.provider<SpecialityRepository>()),
            child: SpecialityPreferencesPage(),
          );
        },
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      onGenerateRoute: onGenerateRoute,
      navigatorKey: Application.navigatorKey,
    );
  }

  @override
  void initState() {
    context.blocProvider<PermissionsBloc>().add(PermissionsCheck());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.blocProvider<PermissionsBloc>().add(PermissionsCheck());
    }
  }
}
