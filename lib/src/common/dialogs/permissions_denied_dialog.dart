import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PermissionsRestrictedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rechten geweigerd'),
      content: const Text(
          'We hebben geconstateerd dat u ons verzoek voor de rechten tot het uitlezen van uw locatie gegeven heeft geweigerd. Om deze app te kunnen gebruiken zult u deze actie ongedaan moeten maken.'),
      actions: <Widget>[
        TextButton(
          child: const Text('Sluiten'),
          onPressed: () async => await SystemNavigator.pop(),
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
