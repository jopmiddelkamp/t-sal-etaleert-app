import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/buttons/tsal-primary-button.dart';
import '../common/bloc/intro/barrel.dart';
import '../common/extensions/build_context.extensions.dart';
import 'home-page.dart';

class IntroPage extends StatelessWidget {
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
                  child: BorderedText(
                    strokeWidth: 6.0,
                    strokeColor: Colors.black12,
                    child: Text(
                      '\'t Sal etaleert',
                      style: textTheme.headline6.copyWith(color: Colors.white),
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
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: BlocConsumer<IntroBloc, IntroState>(
                listener: (context, state) {
                  if (state is IntroAccepted) {
                    context.navigator.pushReplacementNamed(HomePage.routeName);
                  }
                },
                builder: (context, state) {
                  return TSALPrimaryButton(
                    label: const Text('Ga verder'),
                    onTap: () => context.blocProvider<IntroBloc>().add(IntroAccept()),
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
