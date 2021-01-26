import 'package:equatable/equatable.dart';

abstract class IntroEvent extends Equatable {
  const IntroEvent();

  @override
  List<Object> get props => [];
}

class IntroAccept extends IntroEvent {
  @override
  String toString() => 'IntroAccept {}';
}
