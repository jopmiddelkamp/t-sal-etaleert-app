import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppInitialize extends AppEvent {
  const AppInitialize();

  @override
  String toString() => 'AppInitialize {}';
}
