import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'rx_route_step_model.dart';

part 'rx_tour_response_model.g.dart';

@JsonSerializable()
class RxTourResponseModel extends Equatable {
  final String id;
  final int count;
  final bool feasible;
  final Map<String, RxRouteStepModel> route;

  const RxTourResponseModel({
    required this.id,
    required this.count,
    required this.feasible,
    required this.route,
  });

  @override
  String toString() =>
      '${this.runtimeType} { id: $id, count: $count, feasible: $feasible, routeCount: ${route.length} }';

  @override
  List<Object> get props => [
        id,
        count,
        feasible,
        route,
      ];

  factory RxTourResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RxTourResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$RxTourResponseModelToJson(this);
}
