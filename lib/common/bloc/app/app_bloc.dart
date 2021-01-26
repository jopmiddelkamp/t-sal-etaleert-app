import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsal_etaleert/common/services/shared-preferences-service.dart';

import 'barrel.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final SharedPreferencesService _sharedPreferencesService;

  AppBloc(this._sharedPreferencesService)
      : assert(_sharedPreferencesService != null),
        super(AppLoading()) {
    add(AppInitialize());
  }

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppInitialize) {
      yield* _init();
    } else {
      print('AppBloc: unsupported event!');
    }
  }

  Stream<AppState> _init() async* {
    try {
      await _sharedPreferencesService.onReady;
      yield AppLoaded(
        firebaseApp: await Firebase.initializeApp(),
        introAccepted: _sharedPreferencesService.introAccepted,
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      yield AppLoadingError(message: e.toString());
    }
  }
}
