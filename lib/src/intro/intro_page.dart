import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../common/services/persistent_storage/persistent_storage_service.dart';
import 'bloc/intro_bloc.dart';
import 'widgets/continue_button.dart';
import 'widgets/description.dart';
import 'widgets/header.dart';

final sl = GetIt.instance;

class IntroPage extends StatelessWidget {
  static const String routeName = '/route_planner/intro';

  IntroPage._();

  static Widget blocProvider() {
    return BlocProvider(
      create: (context) => IntroBloc(
        persistentStorageService: sl<PersistentStorageService>(),
      ),
      child: IntroPage._(),
    );
  }

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => IntroPage.blocProvider(),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const Header(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: const Description(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: const ContinueButton(),
            ),
          ],
        ),
      ),
    );
  }
}
