import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(
  createFactory: false,
  createToJson: false,
)
class TranslatableStringModel {
  final Map<String, dynamic> _data;

  const TranslatableStringModel(this._data);

  String? getValue([String countryCode = 'nl']) {
    if (_data.containsKey(countryCode) != true) {
      return null;
    }
    return _data[countryCode] as String?;
  }

  factory TranslatableStringModel.fromMap(Map<String, dynamic> map) =>
      TranslatableStringModel(map);

  @override
  String toString() => 'TranslatableString { ${_data.keys.join(',')} }';

  factory TranslatableStringModel.fromJson(Map<String, dynamic> json) =>
      TranslatableStringModel(json);

  Map<String, dynamic> toJson() => _data;
}
