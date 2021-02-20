import 'package:equatable/equatable.dart';
import 'package:tsal_etaleert/common/models/artist.dart';

abstract class SelectStartpointEvent extends Equatable {
  const SelectStartpointEvent();

  @override
  List<Object> get props => [];
}

class SelectStartpointInitialize extends SelectStartpointEvent {
  @override
  String toString() => 'SelectStartpointInitialize {}';
}

class SelectStartpointUpdateArtists extends SelectStartpointEvent {
  final List<Artist> artists;

  const SelectStartpointUpdateArtists(this.artists);

  @override
  String toString() =>
      'SelectStartpointUpdateArtists { artistsCount: ${artists.length} }';
}

class SelectStartpointSelectArtist extends SelectStartpointEvent {
  final Artist artist;

  const SelectStartpointSelectArtist(this.artist);

  @override
  String toString() => 'SelectStartpointSelectArtist { artist: $artist }';
}
