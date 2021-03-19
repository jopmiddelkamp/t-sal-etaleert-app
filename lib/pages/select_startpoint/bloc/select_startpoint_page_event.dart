import 'package:equatable/equatable.dart';

import '../../../common/models/artist_model.dart';

abstract class SelectStartpointPageEvent extends Equatable {
  const SelectStartpointPageEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => '${this.runtimeType} {}';
}

class SelectStartpointInitialize extends SelectStartpointPageEvent {
  final List<String> selectedSpecialityIds;

  const SelectStartpointInitialize({
    required this.selectedSpecialityIds,
  });
}

class SelectStartpointUpdateArtists extends SelectStartpointPageEvent {
  final List<ArtistModel> artists;

  const SelectStartpointUpdateArtists(this.artists);

  @override
  String toString() =>
      '${this.runtimeType} { artistsCount: ${artists.length} }';
}

class SelectStartpointSelectArtist extends SelectStartpointPageEvent {
  final ArtistModel artist;

  const SelectStartpointSelectArtist(this.artist);

  @override
  String toString() => '${this.runtimeType} { artist: $artist }';
}
