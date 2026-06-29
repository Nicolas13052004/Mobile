import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/eleve.dart';
import '../../../core/services/classe_service.dart';

class EleveFormDialog extends StatefulWidget {
  final Eleve? eleve;

  const EleveFormDialog({
    super.key,
    this.eleve,
  });

  @override
  State<EleveFormDialog> createState() => _EleveFormDialogState();
}

class _EleveFormDialogState extends State<EleveFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final ClasseService _classeService = ClasseService();

  late TextEditingController matriculeController; // Ajouté
  late TextEditingController nomController;
  late TextEditingController prenomController;
  late TextEditingController dateNaissanceController;
  
  List<String> classesDisponibles = [];
  String? selectedClasse;
  bool isLoadingClasses = true;

  @override
  void initState() {
    super.initState();

    matriculeController = TextEditingController(text: widget.eleve?.matriculeEleve ?? ""); // Ajouté
    nomController = TextEditingController(text: widget.eleve?.nomEleve ?? "");
    prenomController = TextEditingController(text: widget.eleve?.prenomEleve ?? "");
    dateNaissanceController = TextEditingController(text: widget.eleve?.dateNaissanceEleve ?? "");

    _chargerClassesDepuisSGBD();
  }

  Future<void> _chargerClassesDepuisSGBD() async {
    try {
      final noms = await _classeService.getNomClasses();
      setState(() {
        classesDisponibles = noms;
        
        if (widget.eleve != null && classesDisponibles.contains(widget.eleve!.nomClasseEleve)) {
          selectedClasse = widget.eleve!.nomClasseEleve;
        } else if (classesDisponibles.isNotEmpty) {
          selectedClasse = classesDisponibles.first;
        }
        isLoadingClasses = false;
      });
    } catch (e) {
      setState(() => isLoadingClasses = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Impossible de charger les classes : $e")),
      );
    }
  }

  @override
  void dispose() {
    matriculeController.dispose(); // Ajouté
    nomController.dispose();
    prenomController.dispose();
    dateNaissanceController.dispose();
    super.dispose();
  }

  Future<void> _selectionnerDate(BuildContext context) async {
    DateTime initialDate = DateTime.now().subtract(const Duration(days: 3650));
    if (dateNaissanceController.text.isNotEmpty) {
      try {
        initialDate = DateTime.parse(dateNaissanceController.text);
      } catch (_) {}
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dateNaissanceController.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.eleve != null;

    return AlertDialog(
      title: Text(!isEdit ? "Inscrire un Élève" : "Modifier l'Élève"),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// MATRICULE
                TextFormField(
                  controller: matriculeController,
                  decoration: const InputDecoration(
                    labelText: "Matricule",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Matricule obligatoire";
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                /// NOM (Lettres uniquement)
                TextFormField(
                  controller: nomController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZÀ-ÿ\s'-]")),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Nom de l'élève",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Nom obligatoire";
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                /// PRÉNOM (Lettres uniquement)
                TextFormField(
                  controller: prenomController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZÀ-ÿ\s'-]")),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Prénom",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Prénom obligatoire";
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                /// DATE DE NAISSANCE
                TextFormField(
                  controller: dateNaissanceController,
                  readOnly: true,
                  onTap: () => _selectionnerDate(context),
                  decoration: const InputDecoration(
                    labelText: "Date de naissance",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Date de naissance obligatoire";
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                /// CLASSE (Dropdown dynamique)
                isLoadingClasses
                    ? const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()))
                    : DropdownButtonFormField<String>(
                        value: selectedClasse,
                        decoration: const InputDecoration(
                          labelText: "Classe",
                          border: OutlineInputBorder(),
                        ),
                        items: classesDisponibles.map((String classe) {
                          return DropdownMenuItem<String>(
                            value: classe,
                            child: Text(classe),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Veuillez sélectionner une classe";
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedClasse = value;
                            });
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        FilledButton(
          onPressed: isLoadingClasses
              ? null
              : () {
                  if (!_formKey.currentState!.validate()) return;

                  Navigator.pop(
                    context,
                    {
                      "matriculeEleve": matriculeController.text.trim(), // Envoyé ici
                      "nomEleve": nomController.text.trim(),
                      "prenomEleve": prenomController.text.trim(),
                      "dateNaissanceEleve": dateNaissanceController.text,
                      "nomClasseEleve": selectedClasse,
                      "parentId": widget.eleve?.parentId,
                    },
                  );
                },
          child: const Text("Enregistrer"),
        ),
      ],
    );
  }
}