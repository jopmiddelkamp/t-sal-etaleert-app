import '../../../models/artist_model.dart';

abstract class SelectStartpointPageState {
  const SelectStartpointPageState() : super();

  @override
  String toString() => '${this.runtimeType} {}';
}

class SelectStartpointInitializing extends SelectStartpointPageState {
  const SelectStartpointInitializing();
}

class SelectStartpointUpdated extends SelectStartpointPageState {
  final List<ArtistModel> artists;
  final String? selectedArtistId;

  const SelectStartpointUpdated({
    this.artists = const [],
    this.selectedArtistId,
  });

  bool get hasSelectedArtist => selectedArtistId != null;

  @override
  String toString() =>
      '${this.runtimeType} { artistsCount: ${artists.length}, selectedArtistId: $selectedArtistId }';

  SelectStartpointUpdated copyWith({
    List<ArtistModel>? artists,
    String? selectedArtistId,
  }) {
    return SelectStartpointUpdated(
      artists: artists ?? this.artists,
      selectedArtistId: selectedArtistId ?? this.selectedArtistId,
    );
  }
}

class SelectStartpointNoArtists extends SelectStartpointPageState {
  const SelectStartpointNoArtists();
}
