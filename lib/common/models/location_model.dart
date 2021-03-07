import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel extends Equatable {
  final double latitude;
  final double longitude;

  const LocationModel({
    this.latitude,
    this.longitude,
  });

  factory LocationModel.fromGeoPoint(
    GeoPoint geoPoint,
  ) {
    return LocationModel(
      latitude: geoPoint.latitude,
      longitude: geoPoint.longitude,
    );
  }

  factory LocationModel.fromPosition(
    Position position,
  ) {
    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  String toString() =>
      '${this.runtimeType} { latitude: $latitude, longitude: $longitude }';

  @override
  List<Object> get props => [latitude, longitude];

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
