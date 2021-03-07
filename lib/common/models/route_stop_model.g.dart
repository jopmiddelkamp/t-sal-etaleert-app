// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_stop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteStopModel _$RouteStopModelFromJson(Map<String, dynamic> json) {
  return RouteStopModel(
    artist: json['artist'] == null
        ? null
        : ArtistModel.fromJson(json['artist'] as Map<String, dynamic>),
    completed: json['completed'] as bool,
  );
}

Map<String, dynamic> _$RouteStopModelToJson(RouteStopModel instance) =>
    <String, dynamic>{
      'artist': instance.artist?.toJson(),
      'completed': instance.completed,
    };
