import 'package:flutter/material.dart';
import '../../controllers/note_controller.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  final controller = NoteController();
  List notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future loadNotes() async {
    final data = await controller.getByEleve(1); // ID enfant
    setState(() {
      notes = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes des enfants")),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {

          final n = notes[index];

          return ListTile(
            leading: const Icon(Icons.grade),
            title: Text("Note: ${n['valeur']}"),
            subtitle: Text("Matière: ${n['matiereId']}"),
          );
        },
      ),
    );
  }
}