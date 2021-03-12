import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';

import 'common/bloc/barrel.dart';
import 'common/extensions/build_context_extensions.dart';
import 'common/repositories/barrel.dart';
import 'common/repositories/firestore/barrel.dart';
import 'common/services/barrel.dart';
import 'common/utils/dialog_utils.dart';
import 'constants.dart';
import 'pages/intro/intro_page.dart';
import 'pages/speciality_preferences/bloc/barrel.dart';
import 'pages/speciality_preferences/speciality_preferences_page.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WidgetsBindingObserver, _RepositoriesMixin, _ServicesMixin {
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
                context.provider<SpecialityService>(),
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
    Widget child,
  }) {
    return MultiProvider(
      providers: [
        Provider<ArtistService>(
          create: (_) => _artistService,
        ),
        Provider<LocationService>(
          create: (_) => _locationService,
        ),
        Provider<RouteService>(
          create: (_) => _routeService,
        ),
        Provider<SharedPreferencesService>(
          create: (_) => _sharedPreferencesService,
        ),
        Provider<SpecialityService>(
          create: (_) => _specialityService,
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
            create: (context) {
              final bloc = PermissionsBloc(
                context.provider<SharedPreferencesService>(),
              );
              bloc.add(PermissionsCheck());
              return bloc;
            },
          ),
        ],
        child: child,
      ),
    );
  }

  @override
  void initState() {
    initializeRepositories();
    initializeServices();

    debugPrint('### DEVICE_ID ###');
    PlatformDeviceId.getDeviceId.then((value) => debugPrint(value));

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

  @override
  void initializeRepositories() {
    _artistRepository = FirestoreArtistRepository();
    _routeRepository = FirestoreRouteRepository();
    _specialityRepository = FirestoreSpecialityRepository();
    super.initializeRepositories();
  }

  @override
  void initializeServices() {
    _artistService = ArtistService(
      _artistRepository,
    );
    _locationService = LocationService();
    _routeService = RouteService(
      _routeRepository,
    );
    _sharedPreferencesService = SharedPreferencesService();
    _specialityService = SpecialityService(
      _specialityRepository,
    );
    super.initializeRepositories();
  }
}

mixin _RepositoriesMixin {
  ArtistRepository _artistRepository;
  RouteRepository _routeRepository;
  SpecialityRepository _specialityRepository;

  void initializeRepositories() {
    assert(_artistRepository != null);
    assert(_routeRepository != null);
    assert(_specialityRepository != null);
  }
}

mixin _ServicesMixin {
  ArtistService _artistService;
  LocationService _locationService;
  RouteService _routeService;
  SharedPreferencesService _sharedPreferencesService;
  SpecialityService _specialityService;

  void initializeServices() {
    assert(_artistService != null);
    assert(_locationService != null);
    assert(_routeService != null);
    assert(_sharedPreferencesService != null);
    assert(_specialityService != null);
  }
}
