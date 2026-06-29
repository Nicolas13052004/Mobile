class Absence {
  final int id;

  final String matriculeEleve;
  final String nomCompletEleve;

  final String dateAbsence;
  final String motifAbsence;

  Absence({
    required this.id,
    required this.matriculeEleve,
    required this.nomCompletEleve,
    required this.dateAbsence,
    required this.motifAbsence,
  });

  factory Absence.fromJson(
    Map<String, dynamic> json,
  ) {
    return Absence(
      id: json["id"],

      matriculeEleve:
          json["matriculeEleve"] ?? "",

      nomCompletEleve:
          json["nomCompletEleve"] ?? "",

      dateAbsence:
          json["dateAbsence"] ?? "",

      motifAbsence:
          json["motifAbsence"] ?? "",
    );
  }
}