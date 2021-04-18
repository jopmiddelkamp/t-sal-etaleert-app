import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rx_location_model.g.dart';

@JsonSerializable()
class RxLocationModel extends Equatable {
  final String name;
  final double lat;
  final double lng;

  const RxLocationModel({
    required this.name,
    required this.lat,
    required this.lng,
  });

  @override
  String toString() =>
      '${this.runtimeType} { name: $name, lat: $lat, lng: $lng }';

  @override
  List<Object> get props => [
        name,
        lat,
        lng,
      ];

  factory RxLocationModel.fromJson(Map<String, dynamic> json) =>
      _$RxLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$RxLocationModelToJson(this);
}
