import '../models/translatable_string_model.dart';

extension MapStringStringExtensions on Map<String, dynamic> {
  TranslatableStringModel toTranslatableString() {
    return TranslatableStringModel(this);
  }
}
