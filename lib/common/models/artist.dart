import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../common/models/location.dart';
import 'profile.dart';
import 'speciality.dart';

class Artist extends Equatable {
  final String id;
  final Profile profile;
  final List<Speciality> specialities;
  final Location location;

  const Artist({
    @required this.id,
    @required this.profile,
    @required this.specialities,
    @required this.location,
  });

  @override
  List<Object> get props => [id, profile, specialities];

  @override
  String toString() =>
      '${this.runtimeType} { id: $id, profile: $profile, specialities: $specialities, location: $location }';

  factory Artist.fromMap(String id, Map<String, dynamic> map) {
    final specialities = <Speciality>[];
    final specialitiesMap = (map['specialities'] as Map);
    if (specialitiesMap != null) {
      specialitiesMap.forEach((key, value) {
        final speciality = Speciality.fromMap(key, value);
        specialities.add(speciality);
      });
    }
    return Artist(
      id: id,
      profile: Profile.fromMap(map['profile']),
      specialities: specialities,
      location: Location.fromGeoPoint(map['location']),
    );
  }

  Artist copyWith({
    Profile profile,
    List<String> specialities,
    Location location,
  }) {
    return Artist(
      id: id,
      profile: profile ?? this.profile,
      specialities: specialities ?? this.specialities,
      location: location ?? this.location,
    );
  }
}
