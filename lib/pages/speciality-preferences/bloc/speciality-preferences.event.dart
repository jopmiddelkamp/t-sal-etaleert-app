import 'package:equatable/equatable.dart';

import '../../../common/models/speciality.dart';

abstract class SpecialityPreferencesEvent extends Equatable {
  const SpecialityPreferencesEvent();

  @override
  List<Object> get props => [];
}

class SpecialityPreferencesInitialize extends SpecialityPreferencesEvent {
  @override
  String toString() => 'SpecialityPreferencesInitialize {}';
}

class SpecialityPreferencesUpdateSpecialities
    extends SpecialityPreferencesEvent {
  final List<Speciality> specialities;

  const SpecialityPreferencesUpdateSpecialities(this.specialities);

  @override
  String toString() =>
      'SpecialityPreferencesUpdateSpecialities { specialitiesCount: ${specialities.length} }';
}

class SpecialityPreferencesToggleSpeciality extends SpecialityPreferencesEvent {
  final Speciality speciality;

  const SpecialityPreferencesToggleSpeciality(this.speciality);

  @override
  String toString() =>
      'SpecialityPreferencesToggleSpeciality { speciality: $speciality }';
}
