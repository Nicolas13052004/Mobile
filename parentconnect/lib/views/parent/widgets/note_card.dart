// lib/views/parent/widgets/note_card.dart

import 'package:flutter/material.dart';
import '../../../models/note_parent.dart';

class NoteCard extends StatelessWidget {
  final NoteParent note;

  const NoteCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    // Changement de couleur dynamique en fonction de la moyenne (sur 20)
    final Color indicatorColor = note.valeurNote >= 10 ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: indicatorColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: indicatorColor, width: 2),
          ),
          child: Center(
            child: Text(
              note.valeurNote.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: indicatorColor,
              ),
            ),
          ),
        ),
        title: Text(
          note.nomMatiere,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Coefficient : ${note.coefficientNote}"),
            Text("Élève : ${note.nomCompletEleve}"),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            note.trimestreNote,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}