import 'package:flutter/material.dart';

import '../../../core/services/utilisateur_service.dart';
import '../../../models/utilisateur.dart';

import 'utilisateur_form_dialog.dart';

class UtilisateursPage extends StatefulWidget {
  const UtilisateursPage({
    super.key,
  });

  @override
  State<UtilisateursPage> createState() =>
      _UtilisateursPageState();
}

class _UtilisateursPageState
    extends State<UtilisateursPage> {

  final UtilisateurService service =
      UtilisateurService();

  List<Utilisateur> users = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {

    try {

      final data =
          await service.getAll();

      setState(() {
        users = data;
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

  Future<void> addUser() async {

    final result =
        await showDialog(
      context: context,
      builder: (_) =>
          const UtilisateurFormDialog(),
    );

    if (result == null) return;

    await service.create(result);

    await loadUsers();
  }

  Future<void> editUser(
    Utilisateur user,
  ) async {

    final result =
        await showDialog(
      context: context,

      builder: (_) =>
          UtilisateurFormDialog(
        utilisateur: user,
      ),
    );

    if (result == null) return;

    await service.update(
      user.id,
      result,
    );

    await loadUsers();
  }

  Future<void> deleteUser(
    Utilisateur user,
  ) async {

    final confirm =
        await showDialog<bool>(
      context: context,

      builder: (context) =>
          AlertDialog(
        title: const Text(
          "Suppression",
        ),

        content: Text(
          "Supprimer ${user.nomUtilisateur} ${user.prenomUtilisateur} ?",
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                false,
              );
            },
            child: const Text(
              "Annuler",
            ),
          ),

          FilledButton(
            onPressed: () {
              Navigator.pop(
                context,
                true,
              );
            },
            child: const Text(
              "Supprimer",
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await service.delete(
      user.id,
    );

    await loadUsers();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Gestion Utilisateurs",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: addUser,
        child:
            const Icon(Icons.add),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : users.isEmpty

              ? const Center(
                  child: Text(
                    "Aucun utilisateur",
                  ),
                )

              : ListView.builder(
                  itemCount:
                      users.length,

                  itemBuilder:
                      (context, index) {

                    final user =
                        users[index];

                    return Card(

                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      child: ListTile(

                        leading:
                            const CircleAvatar(
                          child: Icon(
                            Icons.person,
                          ),
                        ),

                        title: Text(
                          "${user.nomUtilisateur} ${user.prenomUtilisateur}",
                        ),

                        subtitle: Text(
                          "${user.emailUtilisateur}\n${user.roleUtilisateur}",
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

                              onPressed: () {
                                editUser(
                                  user,
                                );
                              },
                            ),

                            IconButton(
                              icon:
                                  const Icon(
                                Icons.delete,
                              ),

                              onPressed: () {
                                deleteUser(
                                  user,
                                );
                              },
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