import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';
import 'profile_model.dart';
import 'speciality_model.dart';

part 'artist_model.g.dart';

@JsonSerializable()
class ArtistModel extends Equatable {
  final String id;
  final ProfileModel profile;
  final List<SpecialityModel> specialities;
  final LocationModel location;

  const ArtistModel({
    @required this.id,
    @required this.profile,
    @required this.specialities,
    @required this.location,
  });

  @override
  List<Object> get props => [
        id,
        profile,
        specialities,
      ];

  @override
  String toString() =>
      '${this.runtimeType} { id: $id, profile: $profile, specialities: $specialities, location: $location }';

  factory ArtistModel.fromMap({
    String id,
    Map<String, dynamic> map,
  }) {
    final specialities = <SpecialityModel>[];
    final specialitiesMap = (map['specialities'] as Map);
    if (specialitiesMap != null) {
      specialitiesMap.forEach((key, value) {
        final speciality = SpecialityModel.fromMap(key, value);
        specialities.add(speciality);
      });
    }
    return ArtistModel(
      id: id,
      profile: ProfileModel.fromMap(map['profile']),
      specialities: specialities,
      location: LocationModel.fromGeoPoint(map['location']),
    );
  }

  ArtistModel copyWith({
    ProfileModel profile,
    List<String> specialities,
    LocationModel location,
  }) {
    return ArtistModel(
      id: id,
      profile: profile ?? this.profile,
      specialities: specialities ?? this.specialities,
      location: location ?? this.location,
    );
  }

  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);
}
