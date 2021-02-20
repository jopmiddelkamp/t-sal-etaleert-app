class TranslatableString {
  final Map<String, dynamic> _data;

  const TranslatableString(this._data);

  String getValue([String countryCode = 'nl']) {
    if (_data?.containsKey(countryCode) != true) {
      return null;
    }
    return _data[countryCode] as String;
  }

  factory TranslatableString.fromMap(Map<String, dynamic> map) =>
      TranslatableString(map);

  @override
  String toString() => 'TranslatableString { ${_data.keys.join(',')} }';
}
