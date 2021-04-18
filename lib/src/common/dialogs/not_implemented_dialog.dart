import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

class NotImplementedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nog niet geimplementeerd!'),
      content: const Text('Deze functionaliteit is not niet geimplementeerd.'),
      actions: <Widget>[
        TextButton(
          child: const Text('Sluiten'),
          onPressed: context.navigator.pop,
        ),
      ],
    );
  }
}

void showNotImplementedDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) => NotImplementedDialog(),
  );
}
