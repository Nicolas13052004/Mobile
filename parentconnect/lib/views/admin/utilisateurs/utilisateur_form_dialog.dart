import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/utilisateur.dart';

class UtilisateurFormDialog extends StatefulWidget {
  final Utilisateur? utilisateur;

  const UtilisateurFormDialog({
    super.key,
    this.utilisateur,
  });

  @override
  State<UtilisateurFormDialog> createState() =>
      _UtilisateurFormDialogState();
}

class _UtilisateurFormDialogState
    extends State<UtilisateurFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nomController;
  late TextEditingController prenomController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  String role = "enseignant";

  @override
  void initState() {
    super.initState();

    nomController = TextEditingController(
      text: widget.utilisateur?.nomUtilisateur ?? "",
    );

    prenomController = TextEditingController(
      text: widget.utilisateur?.prenomUtilisateur ?? "",
    );

    emailController = TextEditingController(
      text: widget.utilisateur?.emailUtilisateur ?? "",
    );

    passwordController = TextEditingController();

    role = widget.utilisateur?.roleUtilisateur ??
        "enseignant";
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(
      r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.utilisateur == null
            ? "Ajouter Utilisateur"
            : "Modifier Utilisateur",
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                /// NOM
                TextFormField(
                  controller: nomController,

                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-ZÀ-ÿ\s]")
                    ),
                  ],

                  decoration:
                      const InputDecoration(
                    labelText: "Nom",
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return "Nom obligatoire";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// PRENOM
                TextFormField(
                  controller: prenomController,

                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-ZÀ-ÿ\s]")
                    ),
                  ],

                  decoration:
                      const InputDecoration(
                    labelText: "Prénom",
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return "Prénom obligatoire";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// EMAIL
                TextFormField(
                  controller: emailController,

                  decoration:
                      const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
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

                const SizedBox(height: 15),

                /// PASSWORD
                TextFormField(
                  controller: passwordController,
                  obscureText: true,

                  decoration:
                      const InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {

                    if (widget.utilisateur == null) {

                      if (value == null ||
                          value.isEmpty) {
                        return "Mot de passe obligatoire";
                      }

                      if (value.length < 6) {
                        return "Minimum 6 caractères";
                      }
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// ROLE
                DropdownButtonFormField<String>(
                  value: role,

                  decoration:
                      const InputDecoration(
                    labelText: "Rôle",
                    border: OutlineInputBorder(),
                  ),

                  items: const [

                    DropdownMenuItem(
                      value: "admin",
                      child: Text("Admin"),
                    ),

                    DropdownMenuItem(
                      value: "enseignant",
                      child: Text("Enseignant"),
                    ),

                    DropdownMenuItem(
                      value: "parent",
                      child: Text("Parent"),
                    ),

                    DropdownMenuItem(
                      value: "etudiant",
                      child: Text("Étudiant"),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      role = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Annuler"),
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
                "nomUtilisateur":
                    nomController.text.trim(),

                "prenomUtilisateur":
                    prenomController.text.trim(),

                "emailUtilisateur":
                    emailController.text.trim(),

                "password":
                    passwordController.text.trim(),

                "roleUtilisateur":
                    role,
              },
            );
          },
          child: const Text("Enregistrer"),
        ),
      ],
    );
  }
}