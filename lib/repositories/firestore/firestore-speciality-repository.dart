import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsal_etaleert/common/models/speciality.dart';

import '../speciality-repository.dart';

class FirestoreSpecialityRepository implements SpecialityRepository {
  final CollectionReference _specialityCollection;

  FirestoreSpecialityRepository()
      : _specialityCollection =
            FirebaseFirestore.instance.collection('specialities');

  @override
  Stream<List<Speciality>> getSpecialities([List<String> ids]) {
    // ignore: unnecessary_cast
    var query = _specialityCollection as Query;
    if (ids != null) {
      query = query.where('id', whereIn: ids);
    }
    return query.snapshots().map((docs) {
      return docs.docs
          .map((doc) => Speciality.fromMap(doc.id, doc.data()))
          .toList(growable: false);
    });
  }
}
