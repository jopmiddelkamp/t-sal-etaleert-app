import '../../common/services/service_base.dart';
import '../models/artist_model.dart';
import '../repositories/artist/artist_repository.dart';

abstract class ArtistService {
  Stream<List<ArtistModel>> getArtistsBySpeciality(
    List<String> specialityIds,
  );
}

class ArtistServiceImpl extends ServiceBase implements ArtistService {
  final ArtistRepository _artistRepository;

  const ArtistServiceImpl({
    required final ArtistRepository artistRepository,
  }) : _artistRepository = artistRepository;

  Stream<List<ArtistModel>> getArtistsBySpeciality(
    List<String> specialityIds,
  ) {
    return _artistRepository.getArtistsBySpeciality(
      specialityIds,
    );
  }
}
