// lib/views/admin/classes/classes_page.dart

import 'package:flutter/material.dart';
import '../../../core/services/classe_service.dart';
import '../../../models/classe.dart';
import 'classe_form_dialog.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final ClasseService service = ClasseService();
  List<Classe> classes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadClasses();
  }

  Future<void> loadClasses() async {
    setState(() => isLoading = true);
    try {
      final data = await service.getAll();
      setState(() {
        classes = data;
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

  Future<void> addClasse() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const ClasseFormDialog(),
    );

    if (result == null) return;

    try {
      await service.create(result);
      _showSnackBar("Classe créée avec succès");
      loadClasses();
    } catch (e) {
      _showSnackBar(e.toString(), isError: true);
    }
  }

  Future<void> editClasse(Classe classe) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => ClasseFormDialog(classe: classe),
    );

    if (result == null) return;

    try {
      await service.update(classe.id, result);
      _showSnackBar("Classe mise à jour");
      loadClasses();
    } catch (e) {
      _showSnackBar(e.toString(), isError: true);
    }
  }

  Future<void> deleteClasse(Classe classe) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
        content: Text("Voulez-vous supprimer définitivement la classe '${classe.nomClasse}' ?"),
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
      await service.delete(classe.id);
      _showSnackBar("Classe supprimée");
      loadClasses();
    } catch (e) {
      _showSnackBar(e.toString(), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Classes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadClasses,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addClasse,
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : classes.isEmpty
              ? const Center(child: Text("Aucune classe disponible."))
              : ListView.builder(
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    final classe = classes[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.class_)),
                        title: Text(classe.nomClasse, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(classe.niveauClasse != null && classe.niveauClasse!.isNotEmpty
                            ? "Niveau : ${classe.niveauClasse}"
                            : "Aucun niveau spécifié"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => editClasse(classe),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteClasse(classe),
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