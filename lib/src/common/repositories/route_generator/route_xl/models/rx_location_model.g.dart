// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rx_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RxLocationModel _$RxLocationModelFromJson(Map<String, dynamic> json) {
  return RxLocationModel(
    address: json['address'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RxLocationModelToJson(RxLocationModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
