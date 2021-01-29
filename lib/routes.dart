import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tsal_etaleert/pages/categories-page.dart';

import 'pages/intro-page.dart';
import 'pages/home-page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  // WidgetBuilder builder;
  // bool fullscreenDialog = false;
  switch (settings.name) {
    case IntroPage.routeName:
      return IntroPage.route();
      break;
    case HomePage.routeName:
      return HomePage.route();
      break;
    case CategoriesPage.routeName:
      return CategoriesPage.route();
      break;
    default:
      throw Exception('Invalid route: ${settings.name}');
  }
}
