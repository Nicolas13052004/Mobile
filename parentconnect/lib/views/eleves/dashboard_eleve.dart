import 'package:flutter/material.dart';

import './annoces_page.dart';
import './absences_page.dart';
import './notes_page.dart';

class DashboardEleve extends StatelessWidget {
  const DashboardEleve({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Élève"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [

          _menu(context, "Mes notes", Icons.grade, const NotesPage()),
          _menu(context, "Absences", Icons.event_busy, const AbsencesPage()),
          _menu(context, "Annonces", Icons.campaign, const AnnoncesPage()),
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