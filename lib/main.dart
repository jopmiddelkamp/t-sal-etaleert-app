import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tsal_etaleert/common/services/shared-preferences-service.dart';
import 'package:tsal_etaleert/common/utils/dialog-utils.dart';
import 'package:tsal_etaleert/pages/home-page.dart';

import 'common/bloc/intro/barrel.dart';
import 'common/extensions/build_context.extensions.dart';
import 'common/bloc/barrel.dart';
import 'pages/into-page.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SharedPreferencesService>(create: (_) => SharedPreferencesService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(context.provider<SharedPreferencesService>()),
          ),
        ],
        child: _buildApp(),
      ),
    );
  }

  MaterialApp _buildApp() {
    return MaterialApp(
      title: '\'t Sal etaleert',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppLoadingError) {
            DialogUtils.showErrorDialog(
              context: context,
              title: 'Whoops!',
              message:
                  'Er is een fout opgetreden bij het laden van de app. Sluit de app en probeer het opnieuw. Blijf het fout gaan neem dan contact op met de eigenaar van de app.',
            );
          }
        },
        builder: (context, state) {
          if (state is AppLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is AppLoaded && !state.introAccepted) {
            return BlocProvider(
              create: (context) => IntroBloc(context.provider<SharedPreferencesService>()),
              child: IntroPage(),
            );
          }
          return HomePage();
        },
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      onGenerateRoute: onGenerateRoute,
    );
  }
}
