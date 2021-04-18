// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rx_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RxLocationModel _$RxLocationModelFromJson(Map<String, dynamic> json) {
  return RxLocationModel(
    name: json['name'] as String,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RxLocationModelToJson(RxLocationModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
    };
