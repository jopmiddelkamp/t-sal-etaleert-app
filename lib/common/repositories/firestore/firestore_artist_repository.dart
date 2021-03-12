import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/artist_model.dart';
import '../artist_repository.dart';

class FirestoreArtistRepository implements ArtistRepository {
  final CollectionReference _artistCollection;

  FirestoreArtistRepository()
      : _artistCollection = FirebaseFirestore.instance.collection('artists');

  @override
  Stream<List<ArtistModel>> getArtistsBySpeciality(
      List<String> specialityIds) async* {
    // ignore: unnecessary_cast
    var query = _artistCollection as Query;
    if (specialityIds?.isNotEmpty == true) {
      query = query.where(
        'specialitiesKeys',
        arrayContainsAny: specialityIds,
      );
    }

    yield* query.snapshots().map<List<ArtistModel>>((snapshot) {
      final List<ArtistModel> artists = snapshot.docs
          .map((doc) => ArtistModel.fromMap(
                id: doc.id,
                map: doc.data(),
              ))
          .toList(growable: false);
      artists.forEach((element) {
        print(element.profile.fullName);
      });
      return artists;
    });
  }
}
