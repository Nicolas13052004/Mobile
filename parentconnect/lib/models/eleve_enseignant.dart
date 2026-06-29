class EleveEnseignant {
  final int id;

  final String matriculeEleve;

  final String nomEleve;

  final String prenomEleve;

  final String dateNaissanceEleve;

  final String nomClasseEleve;

  EleveEnseignant({
    required this.id,
    required this.matriculeEleve,
    required this.nomEleve,
    required this.prenomEleve,
    required this.dateNaissanceEleve,
    required this.nomClasseEleve,
  });

  factory EleveEnseignant.fromJson(
    Map<String, dynamic> json,
  ) {
    return EleveEnseignant(
      id: json["id"],

      matriculeEleve:
          json["matriculeEleve"] ?? "",

      nomEleve:
          json["nomEleve"] ?? "",

      prenomEleve:
          json["prenomEleve"] ?? "",

      dateNaissanceEleve:
          json["dateNaissanceEleve"] ?? "",

      nomClasseEleve:
          json["nomClasseEleve"] ?? "",
    );
  }
}