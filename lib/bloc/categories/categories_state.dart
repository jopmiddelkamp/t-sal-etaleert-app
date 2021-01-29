import '../../common/models/category.dart';

abstract class CategoriesState {
  const CategoriesState() : super();
}

class CategoriesInitializing extends CategoriesState {
  @override
  String toString() => 'CategoriesInitializing {}';
}

class CategoriesUpdated extends CategoriesState {
  final List<Category> categories;

  const CategoriesUpdated(this.categories);

  @override
  String toString() => 'CategoriesUpdated { categoriesCount: ${categories.length} }';
}

class NoCategories extends CategoriesState {
  @override
  String toString() => 'NoCategories { }';
}
