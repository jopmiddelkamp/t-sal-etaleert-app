import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/speciality-repository.dart';
import 'barrel.dart';

class SpecialityPreferencesBloc
    extends Bloc<SpecialityPreferencesEvent, SpecialityPreferencesState> {
  final SpecialityRepository _specialityRepository;

  StreamSubscription _specialitiesStreamSub;

  SpecialityPreferencesBloc(
    this._specialityRepository,
  )   : assert(_specialityRepository != null),
        super(SpecialityPreferencesInitializing()) {
    add(SpecialityPreferencesInitialize());
  }

  @override
  Stream<SpecialityPreferencesState> mapEventToState(
    SpecialityPreferencesEvent event,
  ) async* {
    if (event is SpecialityPreferencesInitialize) {
      _init();
    } else if (event is SpecialityPreferencesUpdateSpecialities) {
      yield _loadSpecialities(event);
    } else if (event is SpecialityPreferencesToggleSpeciality) {
      yield _toggleSpeciality(event);
    } else {
      print('SpecialitiesBloc: unsupported event!');
    }
  }

  _init() {
    _specialitiesStreamSub =
        _specialityRepository.getSpecialities().listen((event) {
      add(SpecialityPreferencesUpdateSpecialities(event));
    });
  }

  SpecialityPreferencesState _loadSpecialities(
      SpecialityPreferencesUpdateSpecialities event) {
    if (event.specialities.isEmpty) {
      return SpecialityPreferencesNoSpecialities();
    }
    if (state is SpecialityPreferencesUpdated) {
      return (state as SpecialityPreferencesUpdated).copyWith(
        specialities: event.specialities,
      );
    }
    return SpecialityPreferencesUpdated(
      specialities: event.specialities,
    );
  }

  SpecialityPreferencesState _toggleSpeciality(
      SpecialityPreferencesToggleSpeciality event) {
    if (state is! SpecialityPreferencesUpdated) {
      return state;
    }
    final stateCasted = (state as SpecialityPreferencesUpdated);
    final selectedSpecialityIds = stateCasted.selectedSpecialityIds.toList();
    final index = selectedSpecialityIds.indexOf(event.speciality.id);
    if (index > -1) {
      selectedSpecialityIds.removeAt(index);
    } else {
      selectedSpecialityIds.add(event.speciality.id);
    }
    return stateCasted.copyWith(
      selectedSpecialityIds: selectedSpecialityIds,
    );
  }

  @override
  Future<void> close() {
    _specialitiesStreamSub?.cancel();
    return super.close();
  }
}
