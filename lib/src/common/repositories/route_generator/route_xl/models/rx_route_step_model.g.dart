// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rx_route_step_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RxRouteStepModel _$RxRouteStepModelFromJson(Map<String, dynamic> json) {
  return RxRouteStepModel(
    name: json['name'] as String,
    arrival: json['arrival'] as int,
    distance: (json['distance'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RxRouteStepModelToJson(RxRouteStepModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'arrival': instance.arrival,
      'distance': instance.distance,
    };
