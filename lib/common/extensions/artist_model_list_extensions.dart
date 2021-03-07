import '../models/artist_model.dart';
import '../models/location_model.dart';
import '../utils/location_utils.dart';

extension ArtistModelListExtensions on List<ArtistModel> {
  void sortByDistance(
    LocationModel location,
  ) {
    this.sort((a, b) {
      final distanceToA = LocationUtils.distanceBetween(
        location,
        a.location,
      );
      final distanceToB = LocationUtils.distanceBetween(
        location,
        b.location,
      );
      return distanceToA.compareTo(distanceToB); // Sort by closest
    });
  }
}
