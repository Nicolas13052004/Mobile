import 'package:flutter/material.dart';
import '../../controllers/parent_controller.dart';

class EnfantsPage extends StatefulWidget {
  const EnfantsPage({super.key});

  @override
  State<EnfantsPage> createState() => _EnfantsPageState();
}

class _EnfantsPageState extends State<EnfantsPage> {

  final controller = ParentController();
  List enfants = [];

  @override
  void initState() {
    super.initState();
    loadEnfants();
  }

  Future loadEnfants() async {
    final data = await controller.getAll();
    setState(() {
      enfants = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes enfants")),
      body: ListView.builder(
        itemCount: enfants.length,
        itemBuilder: (context, index) {

          final e = enfants[index];

          return ListTile(
            leading: const Icon(Icons.child_care),
            title: Text("${e['nom']} ${e['prenom']}"),
            subtitle: Text("Classe: ${e['classId']}"),
          );
        },
      ),
    );
  }
}