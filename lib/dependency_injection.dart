import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'environment_variable.dart';
import 'src/common/services/barrel.dart';
import 'src/common/services/location/geo_locator/location_service.dart';
import 'src/common/services/location/location_service.dart';
import 'src/common/services/permission/permission_handler/ph_location_permission_service.dart';
import 'src/common/services/permission/permission_service.dart';
import 'src/common/services/persistent_storage/shared_preferences/sp_persistent_storage_service.dart';
import 'src/route_planner/repositories/artist/artist_repository.dart';
import 'src/route_planner/repositories/artist/firestore/firestore_artist_repository.dart';
import 'src/route_planner/repositories/route/firestore/firestore_route_repository.dart';
import 'src/route_planner/repositories/route/route_repository.dart';
import 'src/route_planner/repositories/route_generator/route_generator_repository.dart';
import 'src/route_planner/repositories/route_generator/route_xl/route_xl_repository.dart';
import 'src/route_planner/repositories/speciality/firestore/firestore_speciality_repository.dart';
import 'src/route_planner/repositories/speciality/speciality_repository.dart';
import 'src/route_planner/services/artist_service.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  await _initEnvironment();

  await sl.allReady();

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
      http: Dio(), // Need custom
      env: sl<EnvironmentVariables>(),
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
    () async => GlLocationServiceImpl(),
  );
  final sp = await SharedPreferences.getInstance();
  sl.registerSingletonAsync<PersistentStorageService>(
    () async => SpPersistentStorageServiceImpl(
      sharedPreferences: sp,
    ),
  );
  sl.registerSingletonWithDependencies<PermissionService>(
    () => PhLocationPermissionServiceImpl(
      persistentStorageService: sl<PersistentStorageService>(),
    ),
    dependsOn: [
      PersistentStorageService,
    ],
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
