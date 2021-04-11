// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rx_tour_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RxTourResponseModel _$RxTourResponseModelFromJson(Map<String, dynamic> json) {
  return RxTourResponseModel(
    id: json['id'] as String,
    count: json['count'] as int,
    feasible: json['feasible'] as bool,
    route: (json['route'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(k, RxRouteStepModel.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$RxTourResponseModelToJson(
        RxTourResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'feasible': instance.feasible,
      'route': instance.route.map((k, e) => MapEntry(k, e.toJson())),
    };
