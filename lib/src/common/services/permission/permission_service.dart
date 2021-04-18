import '../../enums/permission_status_enum.dart';

abstract class PermissionService {
  Future<PermissionStatus> getStatus();
  Future<PermissionStatus> requestPermission();
}
