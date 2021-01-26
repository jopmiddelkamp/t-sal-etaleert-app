class EnumUtils {
  static String getStringValue<T>(T enumValue) {
    if (enumValue == null) {
      return null;
    }
    final String stringValue = enumValue.toString();
    return stringValue.substring(stringValue.indexOf('.') + 1);
  }

  static T enumFromString<T>(List<T> values, String value) {
    if (value == null) {
      return null;
    }
    return values.firstWhere((v) => v.toString().split('.')[1].toLowerCase() == value.toLowerCase(),
        orElse: () => null);
  }
}
