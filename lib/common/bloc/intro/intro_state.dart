abstract class IntroState {
  const IntroState() : super();
}

class IntroAwaitingAcceptence extends IntroState {
  @override
  String toString() => 'IntroAwaitingAcceptence {}';
}

class IntroAccepted extends IntroState {
  @override
  String toString() => 'IntroAccepted {}';
}
