import 'package:flutter/material.dart';
import 'package:mynotes/services/crud/notes_service.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/utilities/dialogs/delete_dialog.dart';

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final void Function(DatabaseNote note) onDeleteNote;
  final void Function(DatabaseNote note) onTapNote;

  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTapNote,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[notes.length - 1 - index];
          return ListTile(
            title: Text(
              note.text,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete),
            ),
            onTap: () => onTapNote(note),
          );
        });
  }
}
