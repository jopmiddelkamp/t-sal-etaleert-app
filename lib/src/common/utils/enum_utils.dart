import 'package:collection/collection.dart' show IterableExtension;

class EnumUtils {
  static String getStringValue<T>(T enumValue) {
    final String stringValue = enumValue.toString();
    return stringValue.substring(stringValue.indexOf('.') + 1);
  }

  static T? enumFromString<T>(List<T> values, String value) {
    return values.firstWhereOrNull(
      (v) => v.toString().split('.')[1].toLowerCase() == value.toLowerCase(),
    );
  }
}
