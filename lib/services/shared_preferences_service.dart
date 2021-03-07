import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'service_base.dart';

class SharedPreferencesService extends ServiceBase {
  final Completer<Null> _readyCompleter = Completer<Null>();

  SharedPreferences _sp;

  static const String introPassedKey = 'SP_INTRO_PASSED';
  static const String lastLocationPermissionStatusKey =
      'SP_LAST_LOCATION_PERMISSION_STATUS';

  SharedPreferencesService() {
    init();
  }

  Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
    _readyCompleter.complete();
  }

  Future<Null> get _onReady =>
      _readyCompleter.isCompleted ? Future.value(null) : _readyCompleter.future;

  Future<bool> getIntroPassed() async {
    await _onReady;
    return _sp.getBool(introPassedKey) ?? false;
  }

  Future<void> setIntroPassed(bool value) async {
    await _onReady;
    _sp.setBool(introPassedKey, value);
  }

  Future<String> getLastLocationPermissionStatus() async {
    await _onReady;
    return _sp.getString(lastLocationPermissionStatusKey);
  }

  Future<void> setLastLocationPermissionStatus(String value) async {
    await _onReady;
    _sp.setString(lastLocationPermissionStatusKey, value);
  }
}
