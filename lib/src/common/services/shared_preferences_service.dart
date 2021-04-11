import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'service_base.dart';

abstract class SharedPreferencesService {
  Future<bool> getIntroPassed();
  Future<void> setIntroPassed(
    bool value,
  );
  Future<String?> getLastLocationPermissionStatus();
  Future<void> setLastLocationPermissionStatus(
    String value,
  );
}

class SharedPreferencesServiceImpl extends ServiceBase
    implements SharedPreferencesService {
  late SharedPreferences _sp;

  static const String introPassedKey = 'SP_INTRO_PASSED';
  static const String lastLocationPermissionStatusKey =
      'SP_LAST_LOCATION_PERMISSION_STATUS';

  SharedPreferencesServiceImpl({
    required final SharedPreferences sharedPreferences,
  }) : _sp = sharedPreferences;

  Future<bool> getIntroPassed() async {
    final intoPassed = _sp.getBool(
      introPassedKey,
    );
    return intoPassed ?? false;
  }

  Future<void> setIntroPassed(
    bool value,
  ) async {
    _sp.setBool(
      introPassedKey,
      value,
    );
  }

  Future<String?> getLastLocationPermissionStatus() async {
    return _sp.getString(
      lastLocationPermissionStatusKey,
    );
  }

  Future<void> setLastLocationPermissionStatus(
    String value,
  ) async {
    _sp.setString(
      lastLocationPermissionStatusKey,
      value,
    );
  }
}
