import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

abstract class AppState {
  const AppState() : super();
}

class AppLoading extends AppState {}

class AppLoaded extends AppState {
  final FirebaseApp firebaseApp;
  final bool introAccepted;

  const AppLoaded({
    @required this.firebaseApp,
    @required this.introAccepted,
  });

  @override
  String toString() => 'AppLoaded { introAccepted: $introAccepted }';
}

class AppLoadingError extends AppState {
  final String message;

  const AppLoadingError({
    @required this.message,
  });

  @override
  String toString() => 'AppLoadingError { message: \'$message\' }';
}
