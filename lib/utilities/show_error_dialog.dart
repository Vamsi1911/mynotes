import 'package:flutter/material.dart';

Future<void> showErrorDialog(String message, BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button to dismiss dialog
    builder: (context) {
      return AlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
