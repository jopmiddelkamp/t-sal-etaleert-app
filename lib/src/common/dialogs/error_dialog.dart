import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;

  const ErrorDialog({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}

void showErrorDialog(
  BuildContext context, {
  required String title,
  required String message,
}) {
  showDialog(
    context: context,
    builder: (context) => ErrorDialog(
      title: title,
      message: message,
    ),
  );
}
