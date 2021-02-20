import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tsal_etaleert/pages/select-startpoint/select-startpoint.page.dart';

import 'pages/intro/intro-page.dart';
import 'pages/home/home-page.dart';
import 'pages/speciality-preferences/speciality-preferences.page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  // WidgetBuilder builder;
  // bool fullscreenDialog = false;
  switch (settings.name) {
    case IntroPage.routeName:
      return IntroPage.route();
    case HomePage.routeName:
      return HomePage.route();
    case SpecialityPreferencesPage.routeName:
      return SpecialityPreferencesPage.route();
    case SelectStartpointPage.routeName:
      if (settings.arguments is! SelectStartpointPageArguments) {
        _thowInvalidArgumentException(SelectStartpointPage.routeName, settings,
            SelectStartpointPageArguments);
      }
      return SelectStartpointPage.route(settings.arguments);
    default:
      throw Exception('Invalid route: ${settings.name}');
  }
}

void _thowInvalidArgumentException(
    String routeName, RouteSettings settings, Type expectedType) {
  throw Exception(
      '$routeName: argument type mismatch. Arguments type is ${settings.arguments.runtimeType} but the expected type is $expectedType.');
}
