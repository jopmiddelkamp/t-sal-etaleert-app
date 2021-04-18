import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

class PermissionsRestrictedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rechten ontnomen'),
      content: const Text(
          'We hebben geconstateerd dat u ons de rechten tot het uitlezen van uw locatie gegeven heeft ontnomen. Om deze app te kunnen gebruiken zult u deze actie ongedaan moeten maken.'),
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
    builder: (context) => PermissionsRestrictedDialog(),
  );
}
