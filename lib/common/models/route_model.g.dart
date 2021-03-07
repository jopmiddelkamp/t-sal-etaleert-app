// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) {
  return RouteModel(
    id: json['id'] as String,
    stops: (json['stops'] as List)
        ?.map((e) => e == null
            ? null
            : RouteStopModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stops': instance.stops?.map((e) => e?.toJson())?.toList(),
    };
