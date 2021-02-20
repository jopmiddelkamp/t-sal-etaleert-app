import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tsal_etaleert/services/location.service.dart';

import '../../../common/models/location.dart';
import '../../../repositories/artist-repository.dart';
import '../../../pages/speciality-preferences/bloc/barrel.dart';
import 'barrel.dart';

class SelectStartpointBloc
    extends Bloc<SelectStartpointEvent, SelectStartpointState> {
  final ArtistRepository _artistRepository;
  final LocationService _locationService;
  final SpecialityPreferencesBloc _specialitiesBloc;

  StreamSubscription _specialitiesStreamSub;
  StreamSubscription _artistsStreamSub;

  SelectStartpointBloc(
    this._artistRepository,
    this._locationService,
    this._specialitiesBloc,
  )   : assert(_artistRepository != null),
        assert(_locationService != null),
        assert(_specialitiesBloc != null),
        super(SelectStartpointInitializing()) {
    add(SelectStartpointInitialize());
  }

  @override
  Stream<SelectStartpointState> mapEventToState(
    SelectStartpointEvent event,
  ) async* {
    if (event is SelectStartpointInitialize) {
      _init();
    } else if (event is SelectStartpointUpdateArtists) {
      yield _updateArtists(event);
    } else if (event is SelectStartpointSelectArtist) {
      yield _selectArtist(event);
    } else {
      print('SelectStartpointBloc: unsupported event!');
    }
  }

  void _init() {
    _specialitiesStreamSub?.cancel();
    _specialitiesStreamSub = _specialitiesBloc
        .startWith(_specialitiesBloc.state)
        .listen((specialitiesState) {
      if (specialitiesState is SpecialityPreferencesNoSpecialities) {
        add(SelectStartpointUpdateArtists([]));
      } else if (specialitiesState is SpecialityPreferencesUpdated) {
        print(specialitiesState);
        _artistsStreamSub?.cancel();
        _artistsStreamSub = _artistRepository
            .getArtistsBySpeciality(specialitiesState.selectedSpecialityIds)
            .listen((artists) async {
          final location = await _locationService.getCurrentLocation();
          print('location: $location');
          artists.sort((a, b) {
            final distanceToA =
                _locationService.distanceBetween(location, a.location);
            print('distance to ${a.profile.fullName}: $distanceToA');
            final distanceToB =
                _locationService.distanceBetween(location, b.location);
            print('distance to ${b.profile.fullName}: $distanceToB');
            return distanceToA.compareTo(distanceToB); // Sort by closest
          });
          add(SelectStartpointUpdateArtists(artists.take(2).toList()));
        });
      }
    });
  }

  SelectStartpointState _updateArtists(
    SelectStartpointUpdateArtists event,
  ) {
    if (event.artists.isEmpty) {
      return SelectStartpointNoArtists();
    }
    if (state is SelectStartpointUpdated) {
      return (state as SelectStartpointUpdated).copyWith(
        artists: event.artists,
      );
    }
    return SelectStartpointUpdated(
      artists: event.artists,
    );
  }

  SelectStartpointState _selectArtist(
    SelectStartpointSelectArtist event,
  ) {
    if (state is! SelectStartpointUpdated) {
      return state;
    }
    return (state as SelectStartpointUpdated).copyWith(
      selectedArtistId: event.artist.id,
    );
  }

  @override
  Future close() {
    _specialitiesStreamSub?.cancel();
    _artistsStreamSub?.cancel();
    return super.close();
  }
}
