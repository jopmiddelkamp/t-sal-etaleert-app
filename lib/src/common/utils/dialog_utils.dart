import 'package:flutter/material.dart';

import '../../constants.dart';
import '../extensions/barrel.dart';

class DialogUtils {
  /// Method to show an error dialog. Note: please try to provide the build context if possible.
  static Future<void> showErrorDialog({
    BuildContext? context,
    required String title,
    required String message,
  }) {
    return showDialog<void>(
      context:
          context ?? Application.navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error),
              const SizedBox(width: 4),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Oke'),
            )
          ],
        );
      },
    );
  }

  static Future<void> showNotImplementedYetDialog({
    BuildContext? context,
  }) {
    return showDialog<void>(
      context:
          context ?? Application.navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nog niet geimplementeerd!'),
          content:
              const Text('Deze functionaliteit is not niet geimplementeerd.'),
          actions: <Widget>[
            new TextButton(
              child: const Text('Sluiten'),
              onPressed: context.navigator.pop,
            ),
          ],
        );
      },
    );
  }
}
