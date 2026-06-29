import 'package:flutter/material.dart';
import '../../../core/services/eleve_service.dart';
import '../../../models/eleve.dart';
import 'eleve_form_dialog.dart';

class ElevesPage extends StatefulWidget {
  const ElevesPage({super.key});

  @override
  State<ElevesPage> createState() => _ElevesPageState();
}

class _ElevesPageState extends State<ElevesPage> {
  final EleveService service = EleveService();
  List<Eleve> eleves = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadEleves();
  }

  Future<void> loadEleves() async {
    try {
      final data = await service.getAll();
      setState(() {
        eleves = data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> addEleve() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const EleveFormDialog(),
    );

    if (result == null) return;

    try {
      await service.create(result);
      await loadEleves();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e")),
      );
    }
  }

  Future<void> editEleve(Eleve eleve) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => EleveFormDialog(eleve: eleve),
    );

    if (result == null) return;

    try {
      await service.update(eleve.id, result);
      await loadEleves();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e")),
      );
    }
  }

  Future<void> deleteEleve(Eleve eleve) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Suppression"),
        content: Text("Supprimer l'élève ${eleve.nomEleve} ${eleve.prenomEleve} ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annuler"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await service.delete(eleve.id);
    await loadEleves();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion Éleves"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addEleve,
        child: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : eleves.isEmpty
              ? const Center(child: Text("Aucun élève inscrit"))
              : ListView.builder(
                  itemCount: eleves.length,
                  itemBuilder: (context, index) {
                    final eleve = eleves[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.school),
                        ),
                        title: Text("${eleve.nomEleve} ${eleve.prenomEleve}"),
                        // Matricule affiché au début du sous-titre
                        subtitle: Text("Matricule : ${eleve.matriculeEleve}\nClasse : ${eleve.nomClasseEleve}\nNé(e) le : ${eleve.dateNaissanceEleve}"),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => editEleve(eleve),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteEleve(eleve),
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