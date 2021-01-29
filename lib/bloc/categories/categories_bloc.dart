import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/category-repository.dart';
import 'barrel.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoryRepository _categoryRepository;

  StreamSubscription _categoriesStreamSub;

  CategoriesBloc(
    this._categoryRepository,
  )   : assert(_categoryRepository != null),
        super(CategoriesInitializing()) {
    add(CategoriesInitialize());
  }

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is CategoriesInitialize) {
      _init();
    } else if (event is CategoriesChanged) {
      yield _loadCategories(event);
    } else {
      print('CategoriesBloc: unsupported event!');
    }
  }

  _init() {
    _categoriesStreamSub = _categoryRepository.getCategories().listen((event) {
      add(CategoriesChanged(event));
    });
  }

  CategoriesState _loadCategories(CategoriesChanged event) {
    if (event.categories.isEmpty) {
      return NoCategories();
    }
    return CategoriesUpdated(event.categories);
  }

  @override
  Future<void> close() {
    _categoriesStreamSub?.cancel();
    return super.close();
  }
}
