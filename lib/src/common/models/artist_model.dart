import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';
import 'profile_model.dart';
import 'speciality_model.dart';

part 'artist_model.g.dart';

@JsonSerializable()
class ArtistModel extends Equatable {
  final String? id;
  final ProfileModel profile;
  final Map<String, SpecialityModel> specialities;
  final LocationModel location;

  const ArtistModel({
    required this.id,
    required this.profile,
    required this.specialities,
    required this.location,
  });

  @override
  List<Object?> get props => [
        id,
        profile.hashCode,
        specialities.hashCode,
        location.hashCode,
      ];

  @override
  String toString() =>
      '${this.runtimeType} { id: $id, profile: $profile, specialities: $specialities, location: $location }';

  factory ArtistModel.fromMap({
    String? id,
    required Map<String, dynamic> map,
  }) {
    final specialities = <String, SpecialityModel>{};
    final specialitiesMap = (map['specialities'] as Map);
    specialitiesMap.forEach((key, value) {
      final specialityMap = value as Map;
      final speciality = SpecialityModel.fromMap(
        key,
        specialityMap as Map<String, dynamic>,
      );
      specialities[key] = speciality;
    });
    return ArtistModel(
      id: id,
      profile: ProfileModel.fromMap(
        map['profile'],
      ),
      specialities: specialities,
      location: LocationModel.fromDynamic(
        map['location'],
      ),
    );
  }

  ArtistModel copyWith({
    ProfileModel? profile,
    List<String>? specialities,
    LocationModel? location,
  }) {
    return ArtistModel(
      id: id,
      profile: profile ?? this.profile,
      specialities:
          specialities as Map<String, SpecialityModel>? ?? this.specialities,
      location: location ?? this.location,
    );
  }

  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);
}
