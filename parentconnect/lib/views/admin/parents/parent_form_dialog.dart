import 'package:flutter/material.dart';

class ParentFormDialog extends StatefulWidget {
  final Map<String, dynamic>? parent;

  const ParentFormDialog({
    super.key,
    this.parent,
  });

  @override
  State<ParentFormDialog> createState() =>
      _ParentFormDialogState();
}

class _ParentFormDialogState
    extends State<ParentFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController matriculeController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController(
      text: widget.parent?["emailParent"] ?? "",
    );

    matriculeController =
        TextEditingController(
      text: widget.parent?["matriculeEleve"] ?? "",
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    matriculeController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(
      r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.parent == null
            ? "Ajouter Liaison"
            : "Modifier Liaison",
      ),

      content: SizedBox(
        width: 400,

        child: Form(
          key: _formKey,

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [

              TextFormField(
                controller:
                    emailController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Email Parent",
                  border:
                      OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Email obligatoire";
                  }

                  if (!isValidEmail(value)) {
                    return "Email invalide";
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 15,
              ),

              TextFormField(
                controller:
                    matriculeController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Matricule Élève",
                  border:
                      OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Matricule obligatoire";
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Annuler",
          ),
        ),

        FilledButton(
          onPressed: () {

            if (!_formKey.currentState!
                .validate()) {
              return;
            }

            Navigator.pop(
              context,
              {
                "emailParent":
                    emailController.text.trim(),

                "matriculeEleve":
                    matriculeController.text.trim(),
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