import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'dependency_injection.dart';
import 'environment_variable.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  await initServiceLocator();
  final env = GetIt.instance<EnvironmentVariables>().environment;
  if (env == Environment.prod) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  // To handle all handled and unhandled exceptions.
  // https://levelup.gitconnected.com/three-things-you-didnt-know-about-exception-handling-in-dart-and-flutter-d021e1458f08
  runZonedGuarded(() {
    runApp(
      MyApp.blocProvider(),
    );
  }, (e, s) {
    print(
        'Synchronous or Asynchronous Exception: $e (stack $s) was caught in our custom zone - redirect to Firebase.');
  });
}
