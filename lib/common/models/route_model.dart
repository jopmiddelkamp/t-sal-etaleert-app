import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'route_stop_model.dart';

part 'route_model.g.dart';

@JsonSerializable()
class RouteModel {
  final String id;
  final List<RouteStopModel> stops;

  const RouteModel({
    @required this.id,
    @required List<RouteStopModel> stops,
  }) : this.stops = stops ?? const [];

  List<String> get artistIds =>
      stops.map((e) => e.artist.id).toList(growable: false);

  List<String> get specialityIds => stops
      .expand((e) => e.artist.specialities)
      .map((e) => e.id)
      .toSet()
      .toList(growable: false);

  factory RouteModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) =>
      RouteModel(
        id: id,
        stops: _mapStops(map),
      );

  static List<RouteStopModel> _mapStops(Map<String, dynamic> map) {
    return (map['stops'] as List).map((value) {
      return RouteStopModel.fromMap(value);
    }).toList();
  }

  RouteModel copyWith({
    String name,
    List<RouteStopModel> stops,
  }) {
    return RouteModel(
      id: id,
      stops: stops ?? this.stops,
    );
  }

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);
  Map<String, dynamic> toJson() {
    final result = _$RouteModelToJson(this);
    // Added for easy lookup on artist or speciality changed
    result['artistIds'] = artistIds;
    result['specialityIds'] = specialityIds;
    return result;
  }
}
