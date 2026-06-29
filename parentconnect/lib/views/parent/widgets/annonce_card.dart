import 'package:flutter/material.dart';
import '../../../models/annonce_parent.dart';

class AnnonceCard extends StatelessWidget {
  final AnnonceParent annonce;

  const AnnonceCard({
    super.key,
    required this.annonce,
  });

  String formatDisplayDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "Date inconnue";
    try {
      final DateTime parsed = DateTime.parse(dateStr);
      return "${parsed.day.toString().padLeft(2, '0')}/${parsed.month.toString().padLeft(2, '0')}/${parsed.year}";
    } catch (_) {
      return dateStr.split('T')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFFFF3E0), // Orange très clair
                  child: Icon(Icons.campaign, color: Colors.orange), // Changement ici
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        annonce.titreAnnonce,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Publié le ${formatDisplayDate(annonce.datePublication)}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Text(
              annonce.contenuAnnonce,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}