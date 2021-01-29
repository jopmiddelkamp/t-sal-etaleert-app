import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../common/models/translatable-string.dart';

class Category extends Equatable {
  final String id;
  final TranslatableString name;

  const Category({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [id, name];

  Map<String, dynamic> toMap() => {
        "name": this.name,
      };

  factory Category.fromMap(String id, Map<String, dynamic> map) => Category(
        id: id,
        name: TranslatableString.fromMap(map['name']),
      );
}
