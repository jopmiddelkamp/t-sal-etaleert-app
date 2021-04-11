// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialityModel _$SpecialityModelFromJson(Map<String, dynamic> json) {
  return SpecialityModel(
    id: json['id'] as String?,
    name:
        TranslatableStringModel.fromJson(json['name'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SpecialityModelToJson(SpecialityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name.toJson(),
    };
