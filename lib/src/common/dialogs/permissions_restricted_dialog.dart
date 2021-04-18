import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';

class PermissionsRestrictedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Uw toegang wordt beperkt'),
      content: const Text(
          'Het lijkt erop dat op uw toestel de toegang to de locatie wordt beperkt. Dit kan komen doordat er bijvoorbeeld ouderlijk toezicht is ingeschakeld. De app kan in deze staat niet worden gebruikt.'),
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
