class TranslatableString {
  final Map<String, dynamic> _data;

  const TranslatableString(this._data);

  String getValue([String countryCode = 'nl']) {
    if (_data?.containsKey(countryCode) != true) {
      return null;
    }
    return _data[countryCode] as String;
  }

  Map<String, dynamic> toMap() => _data;

  factory TranslatableString.fromMap(Map<String, dynamic> map) => TranslatableString(map);
}
