import 'package:equatable/equatable.dart';
import 'package:tsal_etaleert/common/models/category.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class CategoriesInitialize extends CategoriesEvent {
  @override
  String toString() => 'CategoriesInitialize {}';
}

class CategoriesChanged extends CategoriesEvent {
  final List<Category> categories;

  const CategoriesChanged(this.categories);

  @override
  String toString() => 'CategoriesChanged { categoriesCount: ${categories.length} }';
}
