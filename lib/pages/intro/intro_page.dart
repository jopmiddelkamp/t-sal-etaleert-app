import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/bloc/permissions/barrel.dart';
import '../../common/extensions/build_context_extensions.dart';
import '../../common/services/shared_preferences_service.dart';
import '../../common/ui/font_weight.dart';
import '../../common/widgets/buttons/tsal_primary_button.dart';
import '../speciality_preferences/speciality_preferences_page.dart';

class IntroPage extends StatelessWidget {
  static const String routeName = '/intro';

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => IntroPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Image.asset(
                      'assets/images/intro-header.jpg',
                      fit: BoxFit.cover,
                      width: constraints.maxWidth,
                      height: constraints.maxWidth / 2,
                    );
                  },
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    '\'t Sal etaleert',
                    style: textTheme.headline6.copyWith(
                      color: Colors.white,
                      fontWeight: TSALFontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'Dit is de introductie text Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.'),
                      const SizedBox(height: 8),
                      Text(
                        'Meer info header',
                        style: textTheme.headline6,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                          'Dit is de introductie text Lorem Ipsum is simply dummy text of the printing and typesetting industry. When an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                      const SizedBox(height: 8),
                      const Text(
                          'Dit is de introductie text Lorem Ipsum is simply dummy. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                      const SizedBox(height: 8),
                      Text(
                        'Rechten',
                        style: textTheme.headline6,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                          'Om de app te kunnen gebruik hebben wij uw locatie gegeven nodig. Wij gebruiken uw locatie gegevens alleen om u van plaats naar plaats te begeleiden.'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: BlocConsumer<PermissionsBloc, PermissionsState>(
                listener: (context, state) {
                  if (state is PermissionsGranted) {
                    context
                        .provider<SharedPreferencesService>()
                        .setIntroPassed(true);
                    context.navigator.pushReplacementNamed(
                        SpecialityPreferencesPage.routeName);
                  }
                },
                builder: (context, state) {
                  return TSALPrimaryButton(
                    label: const Text('Ga verder'),
                    onTap: () {
                      if (state is PermissionsUndetermined) {
                        context
                            .blocProvider<PermissionsBloc>()
                            .add(PermissionsAskUser());
                      } else {
                        context
                            .blocProvider<PermissionsBloc>()
                            .add(PermissionsCheck());
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
