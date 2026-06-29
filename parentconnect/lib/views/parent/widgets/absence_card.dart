import 'package:flutter/material.dart';
import '../../../models/absence_parent.dart';

class AbsenceCard extends StatelessWidget {
  final AbsenceParent absence;

  const AbsenceCard({
    super.key,
    required this.absence,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = absence.estJustifie ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(
            absence.estJustifie ? Icons.check_circle : Icons.warning,
            color: statusColor,
          ),
        ),
        title: Text(
          "Absence du ${absence.dateAbsence}",
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Élève : ${absence.nomCompletEleve}"),
            if (absence.motifAbsence != null && absence.motifAbsence!.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                "Motif : ${absence.motifAbsence}",
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: statusColor),
          ),
          child: Text(
            absence.estJustifie ? "Justifiée" : "Non justifiée",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ),
      ),
    );
  }
}