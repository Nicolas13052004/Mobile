import 'package:flutter/material.dart';

import '../../../models/note.dart';

import '../../../core/services/note_service.dart';

import 'note_form_dialog.dart';

class NotesPage
    extends StatefulWidget {

  const NotesPage({
    super.key,
  });

  @override
  State<NotesPage>
      createState() =>
          _NotesPageState();
}

class _NotesPageState
    extends State<NotesPage> {

  final service =
      NoteService();

  List<Note> notes = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData()
  async {

    final data =
        await service.getAll();

    setState(() {
      notes = data;
      loading = false;
    });
  }

  Future<void> addNote()
  async {

    final result =
        await showDialog(
      context: context,
      builder: (_) =>
          const NoteFormDialog(),
    );

    if (result == null) return;

    await service.create(
      result,
    );

    loadData();
  }

  Future<void> editNote(
    Note note,
  ) async {

    final result =
        await showDialog(
      context: context,
      builder: (_) =>
          NoteFormDialog(
        note: {
          "matriculeEleve":
              note.matriculeEleve,
          "codeMatiere":
              note.codeMatiere,
          "valeurNote":
              note.valeurNote,
          "coefficientNote":
              note.coefficientNote,
          "trimestreNote":
              note.trimestreNote,
        },
      ),
    );

    if (result == null) return;

    await service.update(
      note.id,
      result,
    );

    loadData();
  }

  Future<void> deleteNote(
    Note note,
  ) async {

    await service.delete(
      note.id,
    );

    loadData();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Notes"),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed:
            addNote,
        child:
            const Icon(Icons.add),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : ListView.builder(
              itemCount:
                  notes.length,

              itemBuilder:
                  (_, index) {

                final note =
                    notes[index];

                return Card(

                  child: ListTile(

                    title: Text(
                      note.nomCompletEleve,
                    ),

                    subtitle: Text(
                      "${note.nomMatiere} | Note : ${note.valeurNote} | Coef : ${note.coefficientNote}\n${note.trimestreNote}",
                    ),

                    trailing: Row(
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        IconButton(
                          icon:
                              const Icon(
                            Icons.edit,
                          ),
                          onPressed:
                              () {
                            editNote(
                                note);
                          },
                        ),

                        IconButton(
                          icon:
                              const Icon(
                            Icons.delete,
                          ),
                          onPressed:
                              () {
                            deleteNote(
                                note);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}