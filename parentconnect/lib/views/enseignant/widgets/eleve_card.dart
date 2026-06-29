import 'package:flutter/material.dart';

import '../../../models/eleve_enseignant.dart';

class EleveCard extends StatelessWidget {

  final EleveEnseignant eleve;

  const EleveCard({
    super.key,
    required this.eleve,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      elevation: 2,

      child: ListTile(

        leading: const CircleAvatar(
          child: Icon(
            Icons.person,
          ),
        ),

        title: Text(
          "${eleve.nomEleve} ${eleve.prenomEleve}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 5),

            Text(
              "Matricule : ${eleve.matriculeEleve}",
            ),

            Text(
              "Classe : ${eleve.nomClasseEleve}",
            ),

            Text(
              "Date de naissance : ${eleve.dateNaissanceEleve}",
            ),

          ],

        ),

        isThreeLine: true,

      ),

    );

  }

}