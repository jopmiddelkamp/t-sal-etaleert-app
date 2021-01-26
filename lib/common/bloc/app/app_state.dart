import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

abstract class AppState {
  const AppState() : super();
}

class AppInitializing extends AppState {
  @override
  String toString() => 'AppInitializing { }';
}

class AppInitialized extends AppState {
  final FirebaseApp firebaseApp;
  final bool introAccepted;

  const AppInitialized({
    @required this.firebaseApp,
    @required this.introAccepted,
  });

  @override
  String toString() => 'AppInitialized { introAccepted: $introAccepted }';
}

class AppAppInitializationError extends AppState {
  final String message;

  const AppAppInitializationError({
    @required this.message,
  });

  @override
  String toString() => 'AppAppInitializationError { message: \'$message\' }';
}
