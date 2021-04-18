import 'dart:async';
import 'dart:html';

import '../../enums/permission_enum.dart';
import '../../enums/permission_status_enum.dart';

abstract class PersistentStorageService {
  Future<bool> getIsIntroAccepted();
  Future<void> setIntroAccepted(
    bool value,
  );
  Future<PermissionStatus> getLatestPermissionStatus(
    Permission permission,
  );
  Future<void> setLatestPermissionStatus({
    required Permission permission,
    required PermissionStatus status,
  });
}
