// lib/models/absence_parent.dart

class AbsenceParent {
  final int id;
  final String matriculeEleve;
  final String nomCompletEleve;
  final String nomMatiere;
  final String dateAbsence;
  final String? motifAbsence;
  final bool estJustifie;

  AbsenceParent({
    required this.id,
    required this.matriculeEleve,
    required this.nomCompletEleve,
    required this.nomMatiere,
    required this.dateAbsence,
    this.motifAbsence,
    required this.estJustifie,
  });

  factory AbsenceParent.fromJson(Map<String, dynamic> json) {
    return AbsenceParent(
      id: json['id'] ?? 0,
      matriculeEleve: json['matriculeEleve'] ?? '',
      nomCompletEleve: json['nomCompletEleve'] ?? 'Élève inconnu',
      nomMatiere: json['nomMatiere'] ?? 'Matière inconnue',
      dateAbsence: json['dateAbsence'] ?? '',
      motifAbsence: json['motifAbsence'],
      estJustifie: json['estJustifie'] ?? false,
    );
  }
}