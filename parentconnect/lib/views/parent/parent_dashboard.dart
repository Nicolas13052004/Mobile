import 'package:flutter/material.dart';

import 'enfants_page.dart';
import 'notes_page.dart';
import 'absences_page.dart';
import 'annonces_page.dart';
import 'messages_page.dart';

class DashboardParent extends StatelessWidget {
  const DashboardParent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Parent"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [

          _menu(context, "Enfants", Icons.child_care, const EnfantsPage()),
          _menu(context, "Notes", Icons.grade, const NotesPage()),
          _menu(context, "Absences", Icons.event_busy, const AbsencesPage()),
          _menu(context, "Annonces", Icons.campaign, const AnnoncesPage()),
          _menu(context, "Messages", Icons.message, const MessagesPage()),
        ],
      ),
    );
  }

  Widget _menu(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}