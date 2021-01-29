import 'package:tsal_etaleert/common/models/category.dart';

abstract class CategoryRepository {
  Stream<List<Category>> getCategories();
}
