import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/services/barrel.dart';
import 'intro_state.dart';

class IntroBloc extends Cubit<IntroState> {
  final PersistentStorageService _ps;

  IntroBloc({
    required PersistentStorageService persistentStorageService,
  })   : _ps = persistentStorageService,
        super(Initializing()) {
    _init();
  }

  Future<void> _init() async {
    final isIntroAccepted = await _ps.getIsIntroAccepted();
    if (isIntroAccepted) {
      emit(Accepted());
    } else {
      emit(Loaded());
    }
  }

  Future<void> accept() async {
    await _ps.setIntroAccepted(true);
    emit(Accepted());
  }
}
