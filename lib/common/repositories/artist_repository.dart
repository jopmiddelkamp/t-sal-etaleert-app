import '../models/artist_model.dart';

abstract class ArtistRepository {
  Stream<List<ArtistModel>> getArtistsBySpeciality(List<String> specialityIds);
}
