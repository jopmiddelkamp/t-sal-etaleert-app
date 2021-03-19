import '../models/speciality_model.dart';
import '../repositories/speciality_repository.dart';
import 'service_base.dart';

class SpecialityService extends ServiceBase {
  final SpecialityRepository _specialityRepository;

  const SpecialityService(
    this._specialityRepository,
  );

  Stream<List<SpecialityModel>> getSpecialities([
    List<String>? ids,
  ]) {
    return _specialityRepository.getSpecialities(
      ids,
    );
  }
}
