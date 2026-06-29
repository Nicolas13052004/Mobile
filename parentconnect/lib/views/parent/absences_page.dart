import 'package:flutter/material.dart';
import '../../controllers/absence_controller.dart';

class AbsencesPage extends StatefulWidget {
  const AbsencesPage({super.key});

  @override
  State<AbsencesPage> createState() => _AbsencesPageState();
}

class _AbsencesPageState extends State<AbsencesPage> {

  final controller = AbsenceController();
  List absences = [];

  @override
  void initState() {
    super.initState();
    loadAbsences();
  }

  Future loadAbsences() async {
    final data = await controller.getByEleve(1);
    setState(() {
      absences = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Absences des enfants")),
      body: ListView.builder(
        itemCount: absences.length,
        itemBuilder: (context, index) {

          final a = absences[index];

          return ListTile(
            leading: const Icon(Icons.event_busy),
            title: Text("Date: ${a['date']}"),
            subtitle: Text("Raison: ${a['raison']}"),
          );
        },
      ),
    );
  }
}