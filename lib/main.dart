import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'common/bloc/barrel.dart';
import 'common/extensions/build_context.extensions.dart';
import 'common/services/shared-preferences-service.dart';
import 'common/utils/dialog-utils.dart';
import 'constants.dart';
import 'pages/home-page.dart';
import 'pages/intro-page.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      Provider<SharedPreferencesService>(create: (_) => SharedPreferencesService()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(context.provider<SharedPreferencesService>()),
        ),
        BlocProvider(
          create: (context) => PermissionsBloc(context.provider<SharedPreferencesService>()),
        ),
      ],
      child: MyApp(),
    ),
  ));
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
          return HomePage();
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
