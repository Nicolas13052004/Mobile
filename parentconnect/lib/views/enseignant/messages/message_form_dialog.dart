import 'package:flutter/material.dart';

class MessageFormDialog
    extends StatefulWidget {

  const MessageFormDialog({
    super.key,
  });

  @override
  State<MessageFormDialog>
      createState() =>
          _MessageFormDialogState();
}

class _MessageFormDialogState
    extends State<MessageFormDialog> {

  final formKey =
      GlobalKey<FormState>();

  final emailDestController =
      TextEditingController();

  final contenuController =
      TextEditingController();

  bool isValidEmail(
    String email,
  ) {
    return RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    ).hasMatch(email);
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return AlertDialog(

      title: const Text(
        "Nouveau message",
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
                    emailDestController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Email parent",
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {
                    return "Email obligatoire";
                  }

                  if (!isValidEmail(
                      value)) {
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
                    contenuController,

                maxLines: 5,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Message",
                ),

                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Message obligatoire";
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
                "emailDestinataire":
                    emailDestController.text
                        .trim(),

                "contenuMessage":
                    contenuController.text
                        .trim(),
              },
            );
          },
          child:
              const Text("Envoyer"),
        ),
      ],
    );
  }
}