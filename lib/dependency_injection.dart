import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'environment_variable.dart';
import 'src/common/repositories/artist/artist_repository.dart';
import 'src/common/repositories/artist/firestore/firestore_artist_repository.dart';
import 'src/common/repositories/route/firestore/firestore_route_repository.dart';
import 'src/common/repositories/route/route_repository.dart';
import 'src/common/repositories/route_generator/route_generator_repository.dart';
import 'src/common/repositories/route_generator/route_xl/route_xl_repository.dart';
import 'src/common/repositories/speciality/firestore/firestore_speciality_repository.dart';
import 'src/common/repositories/speciality/speciality_repository.dart';
import 'src/common/services/artist_service.dart';
import 'src/common/services/barrel.dart';
import 'src/common/services/location_service.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  await _initEnvironment();
  _initRepositories();
  await _initServices();

  await sl.allReady();
}

Future<void> _initEnvironment() async {
  final env = await _getEnvironment();
  sl.registerSingletonAsync<EnvironmentVariables>(
    () async => EnvironmentVariablesImpl(
      environment: env,
    ),
  );
}

void _initRepositories() {
  sl.registerSingletonAsync<Dio>(
    () async => Dio(),
    dispose: (dio) => dio.close(),
  );
  sl.registerSingletonAsync<ArtistRepository>(
    () async => FirestoreArtistRepository(),
  );
  sl.registerSingletonAsync<RouteRepository>(
    () async => FirestoreRouteRepository(),
  );
  sl.registerSingletonAsync<SpecialityRepository>(
    () async => FirestoreSpecialityRepository(),
  );
  sl.registerSingletonWithDependencies<RouteGeneratorRepository>(
    () => RouteXlRouteGeneratorRepository(
      http: sl<Dio>(),
      baseUrl: sl<EnvironmentVariables>().routeXlBaseUrl,
    ),
    dependsOn: [
      Dio,
      EnvironmentVariables,
    ],
  );
}

Future<void> _initServices() async {
  sl.registerSingletonWithDependencies<ArtistService>(
    () => ArtistServiceImpl(
      artistRepository: sl<ArtistRepository>(),
    ),
    dependsOn: [
      ArtistRepository,
    ],
  );
  sl.registerSingletonWithDependencies<SpecialityService>(
    () => SpecialityServiceImpl(
      specialityRepository: sl<SpecialityRepository>(),
    ),
    dependsOn: [
      SpecialityRepository,
    ],
  );
  sl.registerSingletonWithDependencies<RouteService>(
    () => RouteServiceImpl(
      routeRepository: sl<RouteRepository>(),
      routeGeneratorRepository: sl<RouteGeneratorRepository>(),
    ),
    dependsOn: [
      RouteRepository,
      RouteGeneratorRepository,
    ],
  );
  sl.registerSingletonAsync<LocationService>(
    () async => LocationServiceImpl(),
  );
  final sp = await SharedPreferences.getInstance();
  sl.registerSingletonAsync<SharedPreferencesService>(
    () async => SharedPreferencesServiceImpl(
      sharedPreferences: sp,
    ),
  );
  // final deviceInfo = DeviceInfoPlugin();
  // sl.registerSingletonAsync<DeviceInfoService>(
  //   () async => DeviceInfoServicePackageInfoImpl(
  //     iosDeviceInfo: Platform.isIOS ? await deviceInfo.iosInfo : null,
  //     androidDeviceInfo:
  //         Platform.isAndroid ? await deviceInfo.androidInfo : null,
  //   ),
  // );
  // final packageInfo = await PackageInfo.fromPlatform();
  // sl.registerSingletonAsync<PackageInfoService>(
  //   () async => PackageInfoServiceImpl(
  //     packageInfo,
  //   ),
  // );
}

Future<Environment> _getEnvironment() async {
  return Environment.dev;
  // TODO: implement flavor
  // final info = await PackageInfo.fromPlatform();
  // final packageNameSplitted = info.packageName.split('.');
  // if (packageNameSplitted.last.startsWith('sta')) {
  //   return Environment.stag;
  // } else if (packageNameSplitted.last.startsWith('dev')) {
  //   return Environment.dev;
  // } else {
  //   return Environment.prod;
  // }
}