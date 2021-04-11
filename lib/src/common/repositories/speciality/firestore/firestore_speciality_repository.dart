import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/speciality_model.dart';
import '../speciality_repository.dart';

class FirestoreSpecialityRepository implements SpecialityRepository {
  final CollectionReference _specialityCollection;

  FirestoreSpecialityRepository()
      : _specialityCollection =
            FirebaseFirestore.instance.collection('specialities');

  @override
  Stream<List<SpecialityModel>> getSpecialities([List<String>? ids]) {
    // ignore: unnecessary_cast
    var query = _specialityCollection as Query;
    if (ids != null) {
      query = query.where('id', whereIn: ids);
    }
    return query.snapshots().map((docs) {
      return docs.docs
          .map((doc) => SpecialityModel.fromMap(doc.id, doc.data()!))
          .toList(growable: false);
    });
  }
}
