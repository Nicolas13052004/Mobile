import 'package:flutter/material.dart';

class NoteFormDialog
    extends StatefulWidget {

  final Map<String, dynamic>? note;

  const NoteFormDialog({
    super.key,
    this.note,
  });

  @override
  State<NoteFormDialog>
      createState() =>
          _NoteFormDialogState();
}

class _NoteFormDialogState
    extends State<NoteFormDialog> {

  final formKey =
      GlobalKey<FormState>();

  late TextEditingController
      matriculeController;

  late TextEditingController
      matiereController;

  late TextEditingController
      noteController;

  late TextEditingController
      coefficientController;

  String trimestre =
      "Trimestre 1";

  @override
  void initState() {
    super.initState();

    matriculeController =
        TextEditingController(
      text:
          widget.note?["matriculeEleve"] ??
              "",
    );

    matiereController =
        TextEditingController(
      text:
          widget.note?["codeMatiere"] ??
              "",
    );

    noteController =
        TextEditingController(
      text: widget.note?["valeurNote"]
              ?.toString() ??
          "",
    );

    coefficientController =
        TextEditingController(
      text: widget.note?[
                  "coefficientNote"]
              ?.toString() ??
          "1",
    );

    trimestre =
        widget.note?["trimestreNote"] ??
            "Trimestre 1";
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      title: Text(
        widget.note == null
            ? "Ajouter Note"
            : "Modifier Note",
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                TextFormField(
                  controller:
                      matriculeController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Matricule Élève",
                  ),
                  validator: (v) =>
                      v == null ||
                              v.isEmpty
                          ? "Obligatoire"
                          : null,
                ),

                const SizedBox(
                  height: 15,
                ),

                TextFormField(
                  controller:
                      matiereController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Code Matière",
                  ),
                  validator: (v) =>
                      v == null ||
                              v.isEmpty
                          ? "Obligatoire"
                          : null,
                ),

                const SizedBox(
                  height: 15,
                ),

                TextFormField(
                  controller:
                      noteController,
                  keyboardType:
                      TextInputType.number,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Note",
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                TextFormField(
                  controller:
                      coefficientController,
                  keyboardType:
                      TextInputType.number,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Coefficient",
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                DropdownButtonFormField(
                  value: trimestre,
                  items: const [

                    DropdownMenuItem(
                      value:
                          "Trimestre 1",
                      child: Text(
                          "Trimestre 1"),
                    ),

                    DropdownMenuItem(
                      value:
                          "Trimestre 2",
                      child: Text(
                          "Trimestre 2"),
                    ),

                    DropdownMenuItem(
                      value:
                          "Trimestre 3",
                      child: Text(
                          "Trimestre 3"),
                    ),
                  ],
                  onChanged: (value) {
                    trimestre =
                        value!;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [

        TextButton(
          onPressed: () =>
              Navigator.pop(
            context,
          ),
          child:
              const Text("Annuler"),
        ),

        FilledButton(
          onPressed: () {

            if (!formKey.currentState!
                .validate()) {
              return;
            }

            Navigator.pop(
              context,
              {
                "matriculeEleve":
                    matriculeController
                        .text
                        .trim(),

                "codeMatiere":
                    matiereController
                        .text
                        .trim(),

                "valeurNote":
                    double.parse(
                  noteController.text,
                ),

                "coefficientNote":
                    int.parse(
                  coefficientController
                      .text,
                ),

                "trimestreNote":
                    trimestre,
              },
            );
          },
          child: const Text(
            "Enregistrer",
          ),
        ),
      ],
    );
  }
}