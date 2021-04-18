// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rx_tour_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RxTourRequestModel _$RxTourRequestModelFromJson(Map<String, dynamic> json) {
  return RxTourRequestModel(
    locations: (json['locations'] as List<dynamic>)
        .map((e) => RxLocationModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RxTourRequestModelToJson(RxTourRequestModel instance) =>
    <String, dynamic>{
      'locations': instance.locations.map((e) => e.toJson()).toList(),
    };
