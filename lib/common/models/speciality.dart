import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'translatable-string.dart';

class Speciality extends Equatable {
  final String id;
  final TranslatableString name;

  const Speciality({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [id, name];

  @override
  String toString() => 'Speciality { id: $id, name: $name }';

  factory Speciality.fromMap(String id, Map<String, dynamic> map) => Speciality(
        id: id,
        name: TranslatableString.fromMap(map['name']),
      );

  Speciality copyWith({
    String name,
    bool selected,
  }) {
    return Speciality(
      id: id,
      name: name ?? this.name,
    );
  }
}
