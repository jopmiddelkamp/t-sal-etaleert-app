import 'package:tsal_etaleert/common/models/translatable-string.dart';

extension MapStringStringExtensions on Map<String, dynamic> {
  TranslatableString toTranslatableString() {
    return TranslatableString(this);
  }
}
