import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsal_etaleert/common/services/shared-preferences-service.dart';

import 'barrel.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final SharedPreferencesService _sharedPreferencesService;

  IntroBloc(this._sharedPreferencesService)
      : assert(_sharedPreferencesService != null),
        super(IntroAwaitingAcceptence());

  @override
  Stream<IntroState> mapEventToState(
    IntroEvent event,
  ) async* {
    if (event is IntroAccept) {
      yield* _accept();
    } else {
      print('IntroBloc: unsupported event!');
    }
  }

  Stream<IntroState> _accept() async* {
    await _sharedPreferencesService.onReady;
    _sharedPreferencesService.introAccepted = true;
    yield IntroAccepted();
  }
}
