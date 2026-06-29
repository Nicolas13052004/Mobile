class Message {
  final int id;

  final String emailExpediteur;
  final String nomExpediteur;

  final String emailDestinataire;
  final String nomDestinataire;

  final String contenuMessage;

  final bool luMessage;

  final String? dateEnvoi;

  Message({
    required this.id,
    required this.emailExpediteur,
    required this.nomExpediteur,
    required this.emailDestinataire,
    required this.nomDestinataire,
    required this.contenuMessage,
    required this.luMessage,
    this.dateEnvoi,
  });

  factory Message.fromJson(
    Map<String, dynamic> json,
  ) {
    return Message(
      id: json["id"],

      emailExpediteur:
          json["emailExpediteur"] ?? "",

      nomExpediteur:
          json["nomExpediteur"] ?? "",

      emailDestinataire:
          json["emailDestinataire"] ?? "",

      nomDestinataire:
          json["nomDestinataire"] ?? "",

      contenuMessage:
          json["contenuMessage"] ?? "",

      luMessage:
          json["luMessage"] ?? false,

      dateEnvoi:
          json["dateEnvoi"],
    );
  }
}