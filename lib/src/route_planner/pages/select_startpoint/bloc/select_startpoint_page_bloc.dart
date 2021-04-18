import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/extensions/artist_model_list_extensions.dart';
import '../../../../common/services/location_service.dart';
import '../../../services/artist_service.dart';
import 'barrel.dart';

class SelectStartpointPageBloc
    extends Bloc<SelectStartpointPageEvent, SelectStartpointPageState> {
  final ArtistService _artistService;
  final LocationService _locationService;

  StreamSubscription? _artistsStreamSub;

  SelectStartpointPageBloc({
    required ArtistService artistService,
    required LocationService locationService,
    required List<String> selectedSpecialityIds,
  })   : _artistService = artistService,
        _locationService = locationService,
        super(SelectStartpointInitializing()) {
    add(SelectStartpointInitialize(
      selectedSpecialityIds: selectedSpecialityIds,
    ));
  }

  @override
  Stream<SelectStartpointPageState> mapEventToState(
    SelectStartpointPageEvent event,
  ) async* {
    if (event is SelectStartpointInitialize) {
      _init(event);
    } else if (event is SelectStartpointUpdateArtists) {
      yield _updateArtists(event);
    } else if (event is SelectStartpointSelectArtist) {
      yield _selectArtist(event);
    } else {
      print('${this.runtimeType}: unsupported event!');
    }
  }

  void _init(
    SelectStartpointInitialize event,
  ) {
    _artistsStreamSub = _artistService
        .getArtistsBySpeciality(event.selectedSpecialityIds)
        .listen((artists) async {
      final location = await _locationService.getCurrentLocation();
      artists.sortByDistance(location);
      add(SelectStartpointUpdateArtists(artists.toList()));
    });
  }

  SelectStartpointPageState _updateArtists(
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

  SelectStartpointPageState _selectArtist(
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
  Future<void> close() {
    _artistsStreamSub?.cancel();
    return super.close();
  }
}
