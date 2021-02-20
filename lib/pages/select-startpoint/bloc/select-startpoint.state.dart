import '../../../common/models/artist.dart';

abstract class SelectStartpointState {
  const SelectStartpointState() : super();
}

class SelectStartpointInitializing extends SelectStartpointState {
  @override
  String toString() => 'SelectStartpointInitializing {}';
}

class SelectStartpointUpdated extends SelectStartpointState {
  final List<Artist> artists;
  final String selectedArtistId;

  const SelectStartpointUpdated({
    this.artists = const [],
    this.selectedArtistId,
  });

  @override
  String toString() =>
      'SelectStartpointUpdated { artistsCount: ${artists.length}, selectedArtistId: $selectedArtistId }';

  SelectStartpointUpdated copyWith({
    List<Artist> artists,
    String selectedArtistId,
  }) {
    return SelectStartpointUpdated(
      artists: artists ?? this.artists,
      selectedArtistId: selectedArtistId ?? this.selectedArtistId,
    );
  }
}

class SelectStartpointNoArtists extends SelectStartpointState {
  @override
  String toString() => 'SelectStartpointNoArtists { }';
}
