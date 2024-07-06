import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> infoDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context,
    title: 'Info',
    content: 'Nothing here yet',
    optionsBuilder: () => {
      'Add soon': false,
      'Ok': true,
    },
  ).then((value) => value ?? false);
}
// Future<bool> infoDialog(
//   BuildContext context,
// ) {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Info'),
//           content: const Text('Nothing here yet'),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//                 child: const Text('Add soon')),
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                 },
//                 child: const Text('OK'))
//           ],
//         );
//       }).then((value) => value ?? false);
// }