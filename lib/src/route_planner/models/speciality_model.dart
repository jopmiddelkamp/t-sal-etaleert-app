import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/models/translatable_string_model.dart';

part 'speciality_model.g.dart';

@JsonSerializable()
class SpecialityModel extends Equatable {
  final String? id;
  final TranslatableStringModel name;

  const SpecialityModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() => 'Speciality { id: $id, name: $name }';

  factory SpecialityModel.fromMap(String id, Map<String, dynamic> map) =>
      SpecialityModel(
        id: id,
        name: TranslatableStringModel.fromMap(map['name']),
      );

  SpecialityModel copyWith({
    String? name,
  }) {
    return SpecialityModel(
      id: id,
      name: name as TranslatableStringModel? ?? this.name,
    );
  }

  factory SpecialityModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialityModelFromJson(json);
  Map<String, dynamic> toJson() => _$SpecialityModelToJson(this);
}
