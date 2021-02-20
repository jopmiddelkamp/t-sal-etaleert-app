import 'package:tsal_etaleert/common/models/speciality.dart';

abstract class SpecialityRepository {
  Stream<List<Speciality>> getSpecialities([List<String> ids]);
}
