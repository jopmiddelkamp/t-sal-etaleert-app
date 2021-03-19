import '../models/speciality_model.dart';

abstract class SpecialityRepository {
  Stream<List<SpecialityModel>> getSpecialities([List<String>? ids]);
}
