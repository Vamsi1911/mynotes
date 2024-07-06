import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context ,
    title: 'Sign Out',
    content: 'Are you sure though ?',
    optionsBuilder: ()=>{
      'Cancel': false,
      'Log out': true,
    },
  ).then((value)=>value??false);
  }

  // return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Sign Out'),
  //         content: const Text('Are you sure though?'),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(false);
  //               },
  //               child: const Text('Cancel')),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(true);
  //               },
  //               child: const Text('Log Out'))
  //         ],
  //       );
  //     }).then((value) => value ?? false);
// }
