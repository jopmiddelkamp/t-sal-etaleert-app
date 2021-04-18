import 'package:permission_handler/permission_handler.dart' as ph;

import '../../../enums/permission_enum.dart';
import '../../../enums/permission_status_enum.dart';
import '../../barrel.dart';
import '../location_permission_service.dart';

class PhLocationPermissionServiceImpl extends LocationPermissionService {
  final PersistentStorageService _persistentStorage;

  PhLocationPermissionServiceImpl({
    required PersistentStorageService persistentStorageService,
  }) : _persistentStorage = persistentStorageService;

  @override
  Future<PermissionStatus> getStatus() async {
    return await _persistentStorage.getLatestPermissionStatus(
      Permission.location,
    );
  }

  @override
  Future<PermissionStatus> requestPermission() async {
    final result = await _requestDeviceForPermission();
    await _persistentStorage.setLatestPermissionStatus(
      permission: Permission.location,
      status: result,
    );
    return result;
  }

  Future<PermissionStatus> _requestDeviceForPermission() async {
    if (await ph.Permission.locationWhenInUse.isRestricted) {
      return PermissionStatus.restricted;
    }
    if (await ph.Permission.locationWhenInUse.isGranted) {
      return PermissionStatus.granted;
    }
    if (await ph.Permission.locationWhenInUse.isDenied) {
      return PermissionStatus.denied;
    }
    return PermissionStatus.removed;
  }
}
