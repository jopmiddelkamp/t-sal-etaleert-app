import 'package:tsal_etaleert/common/models/artist.dart';

abstract class ArtistRepository {
  Stream<List<Artist>> getArtistsBySpeciality(List<String> specialityIds);
}
