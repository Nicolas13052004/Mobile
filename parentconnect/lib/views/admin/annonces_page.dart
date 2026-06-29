import 'package:flutter/material.dart';
import '../../controllers/annonce_controller.dart';

class AnnoncesPage extends StatefulWidget {
  const AnnoncesPage({super.key});

  @override
  State<AnnoncesPage> createState() => _AnnoncesPageState();
}

class _AnnoncesPageState extends State<AnnoncesPage> {
  final controller = AnnonceController();
  List annonces = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    annonces = await controller.getAll();
    setState(() {});
  }

  void openForm({Map? annonce}) {
    final titre = TextEditingController(text: annonce?["titre"]);
    final contenu = TextEditingController(text: annonce?["contenu"]);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(annonce == null ? "Ajouter" : "Modifier"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titre, decoration: const InputDecoration(labelText: "Titre")),
            TextField(controller: contenu, decoration: const InputDecoration(labelText: "Contenu")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (annonce == null) {
                await controller.create({
                  "titre": titre.text,
                  "contenu": contenu.text,
                });
              } 

              Navigator.pop(context);
              load();
            },
            child: const Text("Sauvegarder"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Annonces"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => openForm(),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: annonces.length,
        itemBuilder: (_, i) {
          final a = annonces[i];

          return ListTile(
            title: Text(a["titre"]),
            subtitle: Text(a["contenu"]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => openForm(annonce: a),
                ),
               
              ],
            ),
          );
        },
      ),
    );
  }
}