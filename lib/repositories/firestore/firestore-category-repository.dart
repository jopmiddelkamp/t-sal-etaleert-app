import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsal_etaleert/common/models/category.dart';

import '../category-repository.dart';

class FirestoreCategoryRepository implements CategoryRepository {
  final CollectionReference _categoryCollection;

  FirestoreCategoryRepository() : _categoryCollection = FirebaseFirestore.instance.collection('specialities');

  @override
  Stream<List<Category>> getCategories() {
    return _categoryCollection
        .snapshots()
        .map((docs) => docs.docs.map((doc) => Category.fromMap(doc.id, doc.data())).toList(growable: false));
  }
}
