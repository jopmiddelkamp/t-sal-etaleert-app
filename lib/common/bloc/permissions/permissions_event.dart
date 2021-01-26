import 'package:equatable/equatable.dart';

abstract class PermissionsEvent extends Equatable {
  const PermissionsEvent();

  @override
  List<Object> get props => [];
}

class PermissionsInitialize extends PermissionsEvent {
  @override
  String toString() => 'PermissionsInitialize {}';
}

class PermissionsAskUser extends PermissionsEvent {
  @override
  String toString() => 'PermissionsAccept {}';
}

class PermissionsCheck extends PermissionsEvent {
  @override
  String toString() => 'PermissionsCheck {}';
}
