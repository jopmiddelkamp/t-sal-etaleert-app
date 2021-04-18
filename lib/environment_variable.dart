import 'package:flutter/foundation.dart';

enum Environment { dev, stag, prod }
enum BuildMode { debug, profile, release }

abstract class EnvironmentVariables {
  Environment get environment;
  BuildMode get buildMode;
  String get routeXlBaseUrl;
  String get routeXlUsername;
  String get routeXlPassword;
}

class EnvironmentVariablesImpl extends EnvironmentVariables {
  final Environment _environment;
  // fromEvironment have to be const values
  static const _routeXlBaseUrl = String.fromEnvironment(
    'ROUTE_XL_BASE_URL',
    defaultValue: 'https://api.routexl.com',
  );
  static const _routeXlUsername = String.fromEnvironment(
    'ROUTE_XL_USERNAME',
    defaultValue: 'register your own at routexl.com',
  );
  static const _routeXlPassword = String.fromEnvironment(
    'ROUTE_XL_PASSWORD',
    defaultValue: 'register your own at routexl.com',
  );

  EnvironmentVariablesImpl({
    required Environment environment,
  }) : _environment = environment;

  @override
  Environment get environment => _environment;

  @override
  BuildMode get buildMode {
    if (kReleaseMode) {
      return BuildMode.release;
    } else if (kProfileMode) {
      return BuildMode.profile;
    } else {
      return BuildMode.debug;
    }
  }

  @override
  String get routeXlBaseUrl => _routeXlBaseUrl;

  @override
  String get routeXlPassword => _routeXlPassword;

  @override
  String get routeXlUsername => _routeXlUsername;
}
