// lib/views/admin/classes/classe_form_dialog.dart

import 'package:flutter/material.dart';
import '../../../models/classe.dart';

class ClasseFormDialog extends StatefulWidget {
  final Classe? classe;

  const ClasseFormDialog({super.key, this.classe});

  @override
  State<ClasseFormDialog> createState() => _ClasseFormDialogState();
}

class _ClasseFormDialogState extends State<ClasseFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomController;
  late TextEditingController niveauController;

  @override
  void initState() {
    super.initState();
    nomController = TextEditingController(text: widget.classe?.nomClasse ?? "");
    niveauController = TextEditingController(text: widget.classe?.niveauClasse ?? "");
  }

  @override
  void dispose() {
    nomController.dispose();
    niveauController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.classe != null;

    return AlertDialog(
      title: Text(isEdit ? "Modifier la classe" : "Ajouter une classe"),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: "Nom de la classe (ex: Terminale S)",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return "Le nom est obligatoire";
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: niveauController,
                decoration: const InputDecoration(
                  labelText: "Niveau de la classe (Optionnel)",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(context, {
              "nomClasse": nomController.text.trim(),
              "niveauClasse": niveauController.text.trim(),
            });
          },
          child: const Text("Enregistrer"),
        ),
      ],
    );
  }
}