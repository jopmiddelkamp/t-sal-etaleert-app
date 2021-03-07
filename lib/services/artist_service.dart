import '../common/models/artist_model.dart';
import '../repositories/artist_repository.dart';
import 'service_base.dart';

class ArtistService extends ServiceBase {
  final ArtistRepository _artistRepository;

  const ArtistService(
    this._artistRepository,
  );

  Stream<List<ArtistModel>> getArtistsBySpeciality(
    List<String> specialityIds,
  ) {
    return _artistRepository.getArtistsBySpeciality(
      specialityIds,
    );
  }
}
