import 'package:equatable/equatable.dart';

import '../../../models/speciality_model.dart';

abstract class SpecialityPreferencesPageEvent extends Equatable {
  const SpecialityPreferencesPageEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => '${this.runtimeType} {}';
}

class SpecialityPreferencesInitialize extends SpecialityPreferencesPageEvent {}

class SpecialityPreferencesUpdateSpecialities
    extends SpecialityPreferencesPageEvent {
  final List<SpecialityModel> specialities;

  const SpecialityPreferencesUpdateSpecialities(this.specialities);

  @override
  String toString() =>
      '${this.runtimeType} { specialitiesCount: ${specialities.length} }';
}

class SpecialityPreferencesToggleSpeciality
    extends SpecialityPreferencesPageEvent {
  final SpecialityModel speciality;

  const SpecialityPreferencesToggleSpeciality(this.speciality);

  @override
  String toString() => '${this.runtimeType} { speciality: $speciality }';
}
