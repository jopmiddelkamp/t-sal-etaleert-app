import 'dart:async';
import 'dart:html';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../enums/permission_enum.dart';
import '../../../enums/permission_status_enum.dart';
import '../../../utils/enum_utils.dart';
import '../../barrel.dart';
import '../../service_base.dart';

// PersistentStorageService implementation based on the SharedPreferences
// Flutter package
class SpPersistentStorageServiceImpl extends ServiceBase
    implements PersistentStorageService {
  late SharedPreferences _sp;

  static const String introAcceptedKey = 'SP_INTRO_ACCEPTED';
  static const String lastLocationPermissionStatusKey =
      'SP_LAST_LOCATION_PERMISSION_STATUS';

  SpPersistentStorageServiceImpl({
    required final SharedPreferences sharedPreferences,
  }) : _sp = sharedPreferences;

  Future<bool> getIsIntroAccepted() async {
    final intoPassed = _sp.getBool(
      introAcceptedKey,
    );
    return intoPassed ?? false;
  }

  Future<void> setIntroAccepted(
    bool value,
  ) async {
    _sp.setBool(
      introAcceptedKey,
      value,
    );
  }

  Future<PermissionStatus> getLatestPermissionStatus(
    Permission permission,
  ) async {
    final defaultValue = PermissionStatus.undetermined;
    final statusAsString = _sp.getString(
      EnumUtils.getStringValue(permission),
    );
    if (statusAsString == null) {
      return defaultValue;
    }
    return EnumUtils.enumFromString(
      PermissionStatus.values,
      statusAsString,
      defaultValue: defaultValue,
    );
  }

  Future<void> setLatestPermissionStatus({
    required Permission permission,
    required PermissionStatus status,
  }) async {
    _sp.setString(
      EnumUtils.getStringValue(permission),
      EnumUtils.getStringValue(status),
    );
  }
}
