abstract class IntroState {
  const IntroState();
}

class Initializing extends IntroState {
  const Initializing();

  @override
  String toString() => 'Initializing { }';
}

class Accepted extends IntroState {
  const Accepted();

  @override
  String toString() => 'Accepted { }';
}

class Loaded extends IntroState {
  const Loaded();

  @override
  String toString() => 'Loaded { }';
}
