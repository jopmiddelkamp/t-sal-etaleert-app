// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistModel _$ArtistModelFromJson(Map<String, dynamic> json) {
  return ArtistModel(
    id: json['id'] as String,
    profile: json['profile'] == null
        ? null
        : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
    specialities: (json['specialities'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          e == null
              ? null
              : SpecialityModel.fromJson(e as Map<String, dynamic>)),
    ),
    location: json['location'] == null
        ? null
        : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArtistModelToJson(ArtistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile': instance.profile?.toJson(),
      'specialities':
          instance.specialities?.map((k, e) => MapEntry(k, e?.toJson())),
      'location': instance.location?.toJson(),
    };
