abstract class AppState {
  const AppState() : super();
}

class AppInitializing extends AppState {
  @override
  String toString() => 'AppInitializing { }';
}

class AppInitialized extends AppState {
  final bool introAccepted;

  const AppInitialized({
    required this.introAccepted,
  });

  @override
  String toString() => 'AppInitialized { introAccepted: $introAccepted }';
}

class AppAppInitializationError extends AppState {
  final String message;

  const AppAppInitializationError({
    required this.message,
  });

  @override
  String toString() => 'AppAppInitializationError { message: \'$message\' }';
}
