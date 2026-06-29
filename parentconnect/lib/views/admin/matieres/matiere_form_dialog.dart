// lib/views/admin/matieres/matiere_form_dialog.dart

import 'package:flutter/material.dart';
import '../../../models/matiere.dart';

class MatiereFormDialog extends StatefulWidget {
  final Matiere? matiere;

  const MatiereFormDialog({super.key, this.matiere});

  @override
  State<MatiereFormDialog> createState() => _MatiereFormDialogState();
}

class _MatiereFormDialogState extends State<MatiereFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomController;
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    nomController = TextEditingController(text: widget.matiere?.nomMatiere ?? "");
    codeController = TextEditingController(text: widget.matiere?.codeMatiere ?? "");
  }

  @override
  void dispose() {
    nomController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.matiere != null;

    return AlertDialog(
      title: Text(isEdit ? "Modifier la Matière" : "Ajouter une Matière"),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// CONTROLE NOM MATIERE
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: "Nom de la matière",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Le nom de la matière est obligatoire";
                  }
                  if (value.trim().length < 2) {
                    return "Le nom doit contenir au moins 2 caractères";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              /// CONTROLE CODE MATIERE
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: "Code Matière (ex: MAT-101) - Optionnel",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label_important),
                ),
                onChanged: (value) {
                  // Optionnel : Forcer le code de la matière en majuscules automatiquement
                  final upper = value.toUpperCase();
                  if (upper != value) {
                    codeController.value = codeController.value.copyWith(
                      text: upper,
                      selection: TextSelection.collapsed(offset: upper.length),
                    );
                  }
                },
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
              "nomMatiere": nomController.text.trim(),
              "codeMatiere": codeController.text.trim().isEmpty ? null : codeController.text.trim(),
            });
          },
          child: const Text("Enregistrer"),
        ),
      ],
    );
  }
}