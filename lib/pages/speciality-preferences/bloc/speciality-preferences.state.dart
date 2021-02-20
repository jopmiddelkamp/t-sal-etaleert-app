import '../../../common/models/speciality.dart';

abstract class SpecialityPreferencesState {
  const SpecialityPreferencesState() : super();
}

class SpecialityPreferencesInitializing extends SpecialityPreferencesState {
  @override
  String toString() => 'SpecialityPreferencesState.Initializing {}';
}

class SpecialityPreferencesUpdated extends SpecialityPreferencesState {
  final List<Speciality> specialities;
  final List<String> selectedSpecialityIds;

  const SpecialityPreferencesUpdated({
    this.specialities = const [],
    this.selectedSpecialityIds = const [],
  });

  @override
  String toString() =>
      'SpecialityPreferencesUpdated { specialitiesCount: ${specialities.length}, selectedSpecialityIdsCount: ${selectedSpecialityIds.length} }';

  SpecialityPreferencesUpdated copyWith({
    List<Speciality> specialities,
    List<String> selectedSpecialityIds,
  }) {
    return SpecialityPreferencesUpdated(
      specialities: specialities ?? this.specialities,
      selectedSpecialityIds:
          selectedSpecialityIds ?? this.selectedSpecialityIds,
    );
  }
}

class SpecialityPreferencesNoSpecialities extends SpecialityPreferencesState {
  @override
  String toString() => 'SpecialityPreferencesState.NoSpecialities { }';
}
