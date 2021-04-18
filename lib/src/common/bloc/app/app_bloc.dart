import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/persistent_storage/persistent_storage_service.dart';
import 'barrel.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final PersistentStorageService _persistentStorageService;

  AppBloc({
    required PersistentStorageService persistentStorageService,
  })   : _persistentStorageService = persistentStorageService,
        super(AppInitializing()) {
    add(AppInitialize());
  }

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppInitialize) {
      yield* _init(event);
    } else {
      print('AppBloc: unsupported event!');
    }
  }

  Stream<AppState> _init(
    AppInitialize event,
  ) async* {
    try {
      yield AppInitialized(
        introAccepted: await _persistentStorageService.getIsIntroAccepted(),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      yield AppAppInitializationError(message: e.toString());
    }
  }
}
