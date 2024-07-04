// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'dart:developer' as devtools show log;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/crud/notes_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    _notesService.open();
    super.initState();
  }

  @override
  void dispose() {
    _notesService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Notes'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(newNoteRoute);
                },
                icon: const Icon(Icons.add)),
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout == true) {
                      await AuthService.firebase().logOut();
                      if (!context.mounted) return;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    }
                  case MenuAction.info:
                    final review = await infoDialog(context);
                    if (review) {
                      devtools.log('Ok');
                    } else {
                      devtools.log('Add quickly');
                    }
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                      value: MenuAction.logout, child: Text('Log Out')),
                  PopupMenuItem<MenuAction>(
                      value: MenuAction.info, child: Text('Info'))
                ];
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: _notesService.getorCreateUser(email: userEmail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return StreamBuilder(
                    stream: _notesService.allNotes,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Text('Waiting for all notes');
                        // case ConnectionState.done:
                        //   return const Text('Waiting for all notes...');
                        // default:
                        // return const CircularProgressIndicator();
                        case ConnectionState.active:
                          return const Text('Waiting for all notes...');
                        default:
                          return const CircularProgressIndicator();
                      }
                    });
              default:
                return const CircularProgressIndicator();
            }
          },
        ));
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure though?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Log Out'))
          ],
        );
      }).then((value) => value ?? false);
}

Future<bool> infoDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Info'),
          content: const Text('Nothing here yet'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Add soon')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('OK'))
          ],
        );
      }).then((value) => value ?? false);
}
