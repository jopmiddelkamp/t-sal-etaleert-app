abstract class PermissionsState {
  const PermissionsState() : super();
}

class PermissionsInitializing extends PermissionsState {
  @override
  String toString() => 'PermissionsInitializing {}';
}

class PermissionsUndetermined extends PermissionsState {
  @override
  String toString() => 'PermissionsAwaitingAcceptence {}';
}

class PermissionsRejected extends PermissionsState {
  @override
  String toString() => 'PermissionsPermissionsRejected {}';
}

class PermissionsGranted extends PermissionsState {
  @override
  String toString() => 'PermissionsAccepted {}';
}
