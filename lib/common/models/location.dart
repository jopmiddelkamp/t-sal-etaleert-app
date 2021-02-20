import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class Location extends Equatable {
  final double latitude;
  final double longitude;

  const Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromGeoPoint(
    GeoPoint geoPoint,
  ) {
    return Location(
      latitude: geoPoint.latitude,
      longitude: geoPoint.longitude,
    );
  }

  factory Location.fromPosition(
    Position position,
  ) {
    return Location(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  String toString() =>
      '${this.runtimeType} { latitude: $latitude, longitude: $longitude }';

  @override
  List<Object> get props => [latitude, longitude];
}
