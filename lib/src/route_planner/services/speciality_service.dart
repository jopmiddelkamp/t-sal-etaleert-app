import '../../common/services/service_base.dart';
import '../models/speciality_model.dart';
import '../repositories/speciality/speciality_repository.dart';

abstract class SpecialityService {
  Stream<List<SpecialityModel>> getSpecialities([
    List<String>? ids,
  ]);
}

class SpecialityServiceImpl extends ServiceBase implements SpecialityService {
  final SpecialityRepository _specialityRepository;

  const SpecialityServiceImpl({
    required final SpecialityRepository specialityRepository,
  }) : _specialityRepository = specialityRepository;

  Stream<List<SpecialityModel>> getSpecialities([
    List<String>? ids,
  ]) {
    return _specialityRepository.getSpecialities(
      ids,
    );
  }
}
