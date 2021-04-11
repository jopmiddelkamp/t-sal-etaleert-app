import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rx_route_step_model.g.dart';

@JsonSerializable()
class RxRouteStepModel extends Equatable {
  final String name;
  final int arrival;
  final double distance;

  const RxRouteStepModel({
    required this.name,
    required this.arrival,
    required this.distance,
  });

  @override
  String toString() =>
      '${this.runtimeType} { name: $name, arrival: $arrival, distance: $distance }';

  @override
  List<Object> get props => [
        name,
        arrival,
        distance,
      ];

  factory RxRouteStepModel.fromJson(Map<String, dynamic> json) =>
      _$RxRouteStepModelFromJson(json);
  Map<String, dynamic> toJson() => _$RxRouteStepModelToJson(this);
}
