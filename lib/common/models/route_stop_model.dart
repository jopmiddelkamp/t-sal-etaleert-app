import 'package:json_annotation/json_annotation.dart';

import 'artist_model.dart';

part 'route_stop_model.g.dart';

@JsonSerializable()
class RouteStopModel {
  final ArtistModel artist;
  final bool completed;

  const RouteStopModel({
    required this.artist,
    this.completed = false,
  });

  factory RouteStopModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return RouteStopModel(
      artist: ArtistModel.fromMap(
        id: map['artistId'],
        map: map['artist'],
      ),
      completed: map['completed'],
    );
  }

  RouteStopModel copyWith({
    ArtistModel? artist,
    bool? completed,
  }) {
    return RouteStopModel(
      artist: artist ?? this.artist,
      completed: completed ?? this.completed,
    );
  }

  factory RouteStopModel.fromJson(Map<String, dynamic> json) =>
      _$RouteStopModelFromJson(json);
  Map<String, dynamic> toJson() => _$RouteStopModelToJson(this);
}
