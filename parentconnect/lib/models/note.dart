class Note {
  final int id;

  final String matriculeEleve;
  final String nomCompletEleve;

  final String codeMatiere;
  final String nomMatiere;

  final double valeurNote;

  final int coefficientNote;

  final String trimestreNote;

  Note({
    required this.id,
    required this.matriculeEleve,
    required this.nomCompletEleve,
    required this.codeMatiere,
    required this.nomMatiere,
    required this.valeurNote,
    required this.coefficientNote,
    required this.trimestreNote,
  });

  factory Note.fromJson(
    Map<String, dynamic> json,
  ) {
    return Note(
      id: json["id"],

      matriculeEleve:
          json["matriculeEleve"] ?? "",

      nomCompletEleve:
          json["nomCompletEleve"] ?? "",

      codeMatiere:
          json["codeMatiere"] ?? "",

      nomMatiere:
          json["nomMatiere"] ?? "",

      valeurNote:
          double.tryParse(
                json["valeurNote"]
                    .toString(),
              ) ??
              0,

      coefficientNote:
          int.tryParse(
                json["coefficientNote"]
                    .toString(),
              ) ??
              1,

      trimestreNote:
          json["trimestreNote"] ?? "",
    );
  }
}