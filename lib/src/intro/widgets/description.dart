import 'package:flutter/material.dart';

import '../../common/extensions/build_context_extensions.dart';

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            'Dit is de introductie text Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.'),
        const SizedBox(height: 8),
        Text(
          'Meer info header',
          style: context.textTheme.headline6,
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
          style: context.textTheme.headline6,
        ),
        const SizedBox(height: 8),
        const Text(
            'Om de app te kunnen gebruik hebben wij uw locatie gegeven nodig. Wij gebruiken uw locatie gegevens alleen om u van plaats naar plaats te begeleiden.'),
      ],
    );
  }
}
