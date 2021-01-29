import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/categories/barrel.dart';
import '../components/loading-indicators/circle-loading-indicator.dart';

class CategoriesPage extends StatelessWidget {
  static const String routeName = '/categories';

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => CategoriesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesInitializing) {
          return TSALCircleLoadingIndicator();
        }
        if (state is CategoriesUpdated) {
          return ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return ListTile(
                title: Text(category.name.getValue()),
              );
            },
          );
        }
        return Center(child: Text('No categories to display..'));
      },
    );
  }
}
