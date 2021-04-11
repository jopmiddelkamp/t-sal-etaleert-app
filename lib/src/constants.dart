import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// APPLICATION GLOBALS
class Application {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get navigator => navigatorKey.currentState!;

  static _DefaultSettings defaultSettings = _DefaultSettings();
}

class _DefaultSettings {
  const _DefaultSettings();

  String get artistFallbackImagePath => 'assets/images/unknown-artist.jpg';

  CameraPosition getGoogleMapsCameraPosition(
    LatLng target,
  ) {
    return CameraPosition(
      target: target,
      zoom: 15,
      tilt: 25,
      bearing: 30,
    );
  }
}
