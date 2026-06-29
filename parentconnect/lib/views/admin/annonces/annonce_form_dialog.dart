import 'package:flutter/material.dart';

class AnnonceFormDialog
    extends StatefulWidget {

  final Map<String, dynamic>? annonce;

  const AnnonceFormDialog({
    super.key,
    this.annonce,
  });

  @override
  State<AnnonceFormDialog>
      createState() =>
          _AnnonceFormDialogState();
}

class _AnnonceFormDialogState
    extends State<AnnonceFormDialog> {

  final formKey =
      GlobalKey<FormState>();

  late TextEditingController
      titreController;

  late TextEditingController
      contenuController;

  @override
  void initState() {
    super.initState();

    titreController =
        TextEditingController(
      text: widget.annonce?[
              "titreAnnonce"] ??
          "",
    );

    contenuController =
        TextEditingController(
      text: widget.annonce?[
              "contenuAnnonce"] ??
          "",
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return AlertDialog(

      title: Text(
        widget.annonce == null
            ? "Nouvelle annonce"
            : "Modifier annonce",
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
                    titreController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Titre",
                ),

                validator: (value) {

                  if (value == null ||
                      value
                          .trim()
                          .isEmpty) {
                    return "Titre obligatoire";
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 15,
              ),

              TextFormField(
                controller:
                    contenuController,

                maxLines: 5,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Contenu",
                ),

                validator: (value) {

                  if (value == null ||
                      value
                          .trim()
                          .isEmpty) {
                    return "Contenu obligatoire";
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
            Navigator.pop(
              context,
            );
          },
          child: const Text(
            "Annuler",
          ),
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
                "titreAnnonce":
                    titreController.text
                        .trim(),

                "contenuAnnonce":
                    contenuController.text
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