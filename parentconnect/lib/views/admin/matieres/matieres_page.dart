// lib/views/admin/matieres/matieres_page.dart

import 'package:flutter/material.dart';
import '../../../core/services/matiere_service.dart';
import '../../../models/matiere.dart';
import 'matiere_form_dialog.dart';

class MatieresPage extends StatefulWidget {
  const MatieresPage({super.key});

  @override
  State<MatieresPage> createState() => _MatieresPageState();
}

class _MatieresPageState extends State<MatieresPage> {
  final MatiereService service = MatiereService();
  List<Matiere> matieres = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMatieres();
  }

  Future<void> loadMatieres() async {
    setState(() => isLoading = true);
    try {
      final data = await service.getAll();
      setState(() {
        matieres = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      _showSnackBar(e.toString(), isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> addMatiere() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const MatiereFormDialog(),
    );

    if (result == null) return;

    try {
      await service.create(result);
      _showSnackBar("Matière ajoutée avec succès !");
      loadMatieres();
    } catch (e) {
      _showSnackBar(e.toString(), isError: true);
    }
  }

  Future<void> editMatiere(Matiere matiere) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => MatiereFormDialog(matiere: matiere),
    );

    if (result == null) return;

    try {
      await service.update(matiere.id, result);
      _showSnackBar("Matière mise à jour.");
      loadMatieres();
    } catch (e) {
      _showSnackBar(e.toString(), isError: true);
    }
  }

  Future<void> deleteMatiere(Matiere matiere) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation de suppression"),
        content: Text("Voulez-vous supprimer définitivement la matière '${matiere.nomMatiere}' ?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Annuler")),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await service.delete(matiere.id);
      _showSnackBar("Matière supprimée.");
      loadMatieres();
    } catch (e) {
      _showSnackBar(e.toString(), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Matières"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadMatieres,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addMatiere,
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : matieres.isEmpty
              ? const Center(child: Text("Aucune matière trouvée."))
              : ListView.builder(
                  itemCount: matieres.length,
                  itemBuilder: (context, index) {
                    final matiere = matieres[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          child: Icon(Icons.bookmark, color: Colors.white),
                        ),
                        title: Text(matiere.nomMatiere, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(matiere.codeMatiere != null && matiere.codeMatiere!.isNotEmpty
                            ? "Code : ${matiere.codeMatiere}"
                            : "Pas de code associé"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => editMatiere(matiere),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteMatiere(matiere),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}