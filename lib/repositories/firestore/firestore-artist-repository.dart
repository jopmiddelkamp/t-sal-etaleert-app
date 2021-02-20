import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tsal_etaleert/common/models/speciality.dart';

import '../../common/models/artist.dart';
import '../artist-repository.dart';
import '../speciality-repository.dart';

class FirestoreArtistRepository implements ArtistRepository {
  final SpecialityRepository _specialityRepository;

  final CollectionReference _artistCollection;
  final CollectionReference _specialityCollection;

  FirestoreArtistRepository(this._specialityRepository)
      : assert(_specialityRepository != null),
        _artistCollection = FirebaseFirestore.instance.collection('artists'),
        _specialityCollection =
            FirebaseFirestore.instance.collection('specialities');

  @override
  Stream<List<Artist>> getArtistsBySpeciality(
      List<String> specialityIds) async* {
    debugPrint(
        'FirestoreArtistRepository.getArtistsBySpeciality({ specialityIdsCount: ${specialityIds.length} })');

    // ignore: unnecessary_cast
    var query = _artistCollection as Query;
    if (specialityIds?.isNotEmpty == true) {
      query = query.where(
        'specialitiesKeys',
        arrayContainsAny: specialityIds,
      );
    }

    yield* query.snapshots().map<List<Artist>>((docs) {
      final List<Artist> artists = docs.docs
          .map((doc) => Artist.fromMap(doc.id, doc.data()))
          .toList(growable: false);
      print('### getArtistsBySpeciality ###');
      artists.forEach((element) {
        print(element.profile.fullName);
      });
      return artists;
    });
  }
}
