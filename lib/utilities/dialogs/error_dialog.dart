import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  String text,
  BuildContext context,
) {
  return showGenericDialog(
    context: context,
    title: 'Error',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
