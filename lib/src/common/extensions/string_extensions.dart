import 'dart:convert';

extension StringExtensions on String {
  String toBase64() {
    var bytes = utf8.encode(this);
    var result = base64.encode(bytes);
    return result;
  }
}
