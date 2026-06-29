import 'package:flutter/material.dart';

import '../../../core/services/parent_service.dart';
import '../../../models/parent_eleve.dart';

import 'parent_form_dialog.dart';

class ParentsPage extends StatefulWidget {
  const ParentsPage({
    super.key,
  });

  @override
  State<ParentsPage> createState() =>
      _ParentsPageState();
}

class _ParentsPageState
    extends State<ParentsPage> {

  final ParentService service =
      ParentService();

  List<ParentEleve> parents = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadParents();
  }

  Future<void> loadParents() async {

    try {

      final data =
          await service.getAll();

      setState(() {
        parents = data;
        loading = false;
      });

    } catch (e) {

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> addParent() async {

    final result =
        await showDialog(
      context: context,

      builder: (_) =>
          const ParentFormDialog(),
    );

    if (result == null) return;

    await service.create(result);

    await loadParents();
  }

  Future<void> editParent(
    ParentEleve parent,
  ) async {

    final result =
        await showDialog(
      context: context,

      builder: (_) =>
          ParentFormDialog(
        parent: {
          "emailParent":
              parent.emailParent,

          "matriculeEleve":
              parent.matriculeEleve,
        },
      ),
    );

    if (result == null) return;

    await service.update(
      parent.id,
      result,
    );

    await loadParents();
  }

  Future<void> deleteParent(
    ParentEleve parent,
  ) async {

    final confirm =
        await showDialog<bool>(
      context: context,

      builder: (_) => AlertDialog(
        title: const Text(
          "Confirmation",
        ),

        content: Text(
          "Supprimer la liaison de ${parent.nomParent} ?",
        ),

        actions: [

          TextButton(
            onPressed: () =>
                Navigator.pop(
              context,
              false,
            ),
            child: const Text(
              "Annuler",
            ),
          ),

          FilledButton(
            onPressed: () =>
                Navigator.pop(
              context,
              true,
            ),
            child: const Text(
              "Supprimer",
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await service.delete(
      parent.id,
    );

    await loadParents();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Gestion Parents",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: addParent,
        child:
            const Icon(Icons.add),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : parents.isEmpty

              ? const Center(
                  child: Text(
                    "Aucune liaison",
                  ),
                )

              : ListView.builder(
                  itemCount:
                      parents.length,

                  itemBuilder:
                      (context, index) {

                    final parent =
                        parents[index];

                    return Card(

                      margin:
                          const EdgeInsets.all(8),

                      child: ListTile(

                        leading:
                            const CircleAvatar(
                          child: Icon(
                            Icons.family_restroom,
                          ),
                        ),

                        title: Text(
                          parent.nomParent,
                        ),

                        subtitle: Text(
                          "Email : ${parent.emailParent}\n"
                          "Élève : ${parent.nomEleve}\n"
                          "Matricule : ${parent.matriculeEleve}",
                        ),

                        isThreeLine: true,

                        trailing: Row(
                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            IconButton(
                              icon:
                                  const Icon(
                                Icons.edit,
                              ),
                              onPressed: () =>
                                  editParent(
                                parent,
                              ),
                            ),

                            IconButton(
                              icon:
                                  const Icon(
                                Icons.delete,
                              ),
                              onPressed: () =>
                                  deleteParent(
                                parent,
                              ),
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