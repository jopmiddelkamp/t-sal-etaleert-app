import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'rx_location_model.dart';

part 'rx_tour_request_model.g.dart';

@JsonSerializable()
class RxTourRequestModel extends Equatable {
  final List<RxLocationModel> locations;

  const RxTourRequestModel({
    required this.locations,
  });

  @override
  String toString() =>
      '${this.runtimeType} { locationsCount: ${locations.length} }';

  @override
  List<Object> get props => [
        locations,
      ];

  factory RxTourRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RxTourRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RxTourRequestModelToJson(this);
}
