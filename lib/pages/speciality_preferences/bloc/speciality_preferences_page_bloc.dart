import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/services/speciality_service.dart';
import 'barrel.dart';

class SpecialityPreferencesPageBloc extends Bloc<SpecialityPreferencesPageEvent,
    SpecialityPreferencesPageState> {
  final SpecialityService _specialityService;

  StreamSubscription _specialitiesStreamSub;

  SpecialityPreferencesPageBloc(
    this._specialityService,
  )   : assert(_specialityService != null),
        super(SpecialityPreferencesInitializing()) {
    add(SpecialityPreferencesInitialize());
  }

  @override
  Stream<SpecialityPreferencesPageState> mapEventToState(
    SpecialityPreferencesPageEvent event,
  ) async* {
    if (event is SpecialityPreferencesInitialize) {
      _init();
    } else if (event is SpecialityPreferencesUpdateSpecialities) {
      yield _loadSpecialities(event);
    } else if (event is SpecialityPreferencesToggleSpeciality) {
      yield _toggleSpeciality(event);
    } else {
      print('${this.runtimeType}: unsupported event!');
    }
  }

  _init() {
    _specialitiesStreamSub =
        _specialityService.getSpecialities().listen((event) {
      add(SpecialityPreferencesUpdateSpecialities(event));
    });
  }

  SpecialityPreferencesPageState _loadSpecialities(
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

  SpecialityPreferencesPageState _toggleSpeciality(
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
