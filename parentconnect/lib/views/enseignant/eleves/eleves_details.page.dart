import 'package:flutter/material.dart';

class EleveDetailsPage extends StatelessWidget {
final dynamic eleve;

const EleveDetailsPage({
super.key,
required this.eleve,
});

Widget buildInfoTile(
String label,
String value,
IconData icon) {
return Card(
child: ListTile(
leading: Icon(icon),

    title: Text(label),

    subtitle: Text(
      value.isEmpty ? "-" : value,
    ),
  ),
);

}

@override
Widget build(BuildContext context) {
final nom =
"${eleve["nom"] ?? ""} ${eleve["prenom"] ?? ""}";

return Scaffold(
  appBar: AppBar(
    title: const Text(
      "Fiche Élève",
    ),
  ),

  body: SingleChildScrollView(
    padding: const EdgeInsets.all(16),

    child: Column(
      children: [
        CircleAvatar(
          radius: 50,

          child: Text(
            eleve["prenom"]
                .toString()[0]
                .toUpperCase(),

            style: const TextStyle(
              fontSize: 30,
            ),
          ),
        ),

        const SizedBox(height: 15),

        Text(
          nom,

          style: const TextStyle(
            fontSize: 24,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        buildInfoTile(
          "Nom",
          eleve["nom"] ?? "",
          Icons.person,
        ),

        buildInfoTile(
          "Prénom",
          eleve["prenom"] ?? "",
          Icons.badge,
        ),

        buildInfoTile(
          "Classe",
          "${eleve["classId"] ?? "-"}",
          Icons.school,
        ),

        buildInfoTile(
          "Date de naissance",
          eleve["dateNaissance"] ?? "",
          Icons.calendar_month,
        ),

        buildInfoTile(
          "Sexe",
          eleve["sexe"] ?? "",
          Icons.wc,
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,

          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.grade,
            ),

            label: const Text(
              "Voir les notes",
            ),

            onPressed: () {},
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          width: double.infinity,

          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.event_busy,
            ),

            label: const Text(
              "Voir les absences",
            ),

            onPressed: () {},
          ),
        ),
      ],
    ),
  ),
);

}
}
