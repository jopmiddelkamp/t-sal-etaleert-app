import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/home/home_page.dart';
import 'pages/intro/intro_page.dart';
import 'pages/route/route_page.dart';
import 'pages/select_startpoint/select_startpoint_page.dart';
import 'pages/speciality_preferences/speciality_preferences_page.dart';

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
        _thowInvalidArgumentException(
          SelectStartpointPage.routeName,
          settings,
          SelectStartpointPageArguments,
        );
      }
      return SelectStartpointPage.route(
        settings.arguments as SelectStartpointPageArguments,
      );
    case RoutePage.routeName:
      if (settings.arguments is! RoutePageArguments) {
        _thowInvalidArgumentException(
          RoutePage.routeName,
          settings,
          RoutePageArguments,
        );
      }
      return RoutePage.route(
        settings.arguments as RoutePageArguments,
      );
    default:
      throw Exception('Invalid route: ${settings.name}');
  }
}

void _thowInvalidArgumentException(
  String routeName,
  RouteSettings settings,
  Type expectedType,
) {
  throw Exception(
      '$routeName: argument type mismatch. Arguments type is ${settings.arguments.runtimeType} but the expected type is $expectedType.');
}
