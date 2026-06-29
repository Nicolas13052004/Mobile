import 'package:flutter/material.dart';

class AbsenceFormDialog
    extends StatefulWidget {

  final Map<String, dynamic>? absence;

  const AbsenceFormDialog({
    super.key,
    this.absence,
  });

  @override
  State<AbsenceFormDialog>
      createState() =>
          _AbsenceFormDialogState();
}

class _AbsenceFormDialogState
    extends State<AbsenceFormDialog> {

  final formKey =
      GlobalKey<FormState>();

  late TextEditingController
      matriculeController;

  late TextEditingController
      dateController;

  late TextEditingController
      motifController;

  @override
  void initState() {
    super.initState();

    matriculeController =
        TextEditingController(
      text: widget.absence?[
              "matriculeEleve"] ??
          "",
    );

    dateController =
        TextEditingController(
      text: widget.absence?[
              "dateAbsence"] ??
          "",
    );

    motifController =
        TextEditingController(
      text: widget.absence?[
              "motifAbsence"] ??
          "",
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(

      title: Text(
        widget.absence == null
            ? "Ajouter Absence"
            : "Modifier Absence",
      ),

      content: SizedBox(
        width: 500,

        child: Form(
          key: formKey,

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [

              TextFormField(
                controller:
                    matriculeController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Matricule Élève",
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {
                    return "Obligatoire";
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 15,
              ),

              TextFormField(
                controller:
                    dateController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Date (YYYY-MM-DD)",
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {
                    return "Obligatoire";
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 15,
              ),

              TextFormField(
                controller:
                    motifController,

                maxLines: 3,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Motif",
                ),
              ),
            ],
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
                    matriculeController.text
                        .trim(),

                "dateAbsence":
                    dateController.text
                        .trim(),

                "motifAbsence":
                    motifController.text
                        .trim(),
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