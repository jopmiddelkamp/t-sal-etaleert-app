import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rx_location_model.g.dart';

@JsonSerializable()
class RxLocationModel extends Equatable {
  final String address;
  final double latitude;
  final double longitude;

  const RxLocationModel({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() =>
      '${this.runtimeType} { address: $address, latitude: $latitude, longitude: $longitude }';

  @override
  List<Object> get props => [
        address,
        latitude,
        longitude,
      ];

  factory RxLocationModel.fromJson(Map<String, dynamic> json) =>
      _$RxLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$RxLocationModelToJson(this);
}
