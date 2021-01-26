import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final Completer<Null> _readyCompleter = Completer<Null>();

  SharedPreferences _sp;

  static const String introAcceptedKey = 'SP_INTRO_ACCEPTED';

  static const String uninitializedErrorMessage =
      'SharedPreferencesService not loaded yet. Await the `SharedPreferencesService.onReady` before calling any properties or methods.';

  SharedPreferencesService() {
    init();
  }

  Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
    _readyCompleter.complete();
  }

  bool get ready => _readyCompleter.isCompleted;
  Future<Null> get onReady => ready ? Future.value(null) : _readyCompleter.future;

  bool get introAccepted {
    if (!ready) {
      debugPrint(uninitializedErrorMessage);
    }
    return _sp.getBool(introAcceptedKey) ?? false;
  }

  set introAccepted(bool value) {
    if (!ready) {
      debugPrint(uninitializedErrorMessage);
    }
    _sp.setBool(introAcceptedKey, value);
  }
}
