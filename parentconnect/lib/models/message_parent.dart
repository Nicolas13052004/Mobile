// lib/models/message_parent.dart

class MessageParent {
  final int id;
  final String emailExpediteur;
  final String nomExpediteur;
  final String emailDestinataire;
  final String nomDestinataire;
  final String contenuMessage;
  final bool luMessage;
  final String dateEnvoi;

  MessageParent({
    required this.id,
    required this.emailExpediteur,
    required this.nomExpediteur,
    required this.emailDestinataire,
    required this.nomDestinataire,
    required this.contenuMessage,
    required this.luMessage,
    required this.dateEnvoi,
  });

  factory MessageParent.fromJson(Map<String, dynamic> json) {
    return MessageParent(
      id: json['id'] ?? 0,
      emailExpediteur: json['emailExpediteur'] ?? '',
      nomExpediteur: json['nomExpediteur'] ?? 'Inconnu',
      emailDestinataire: json['emailDestinataire'] ?? '',
      nomDestinataire: json['nomDestinataire'] ?? 'Inconnu',
      contenuMessage: json['contenuMessage'] ?? '',
      luMessage: json['luMessage'] ?? false,
      dateEnvoi: json['dateEnvoi'] ?? '',
    );
  }
}