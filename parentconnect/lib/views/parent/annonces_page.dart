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
    loadAnnonces();
  }

  Future loadAnnonces() async {
    final data = await controller.getAll();
    setState(() {
      annonces = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Annonces")),
      body: ListView.builder(
        itemCount: annonces.length,
        itemBuilder: (context, index) {

          final a = annonces[index];

          return ListTile(
            leading: const Icon(Icons.campaign),
            title: Text(a['titre'] ?? "Annonce"),
            subtitle: Text(a['contenu'] ?? ""),
          );
        },
      ),
    );
  }
}