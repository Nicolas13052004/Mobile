// lib/models/note_parent.dart

class NoteParent {
  final int id;
  final String matriculeEleve;
  final String nomCompletEleve;
  final String codeMatiere;
  final String nomMatiere;
  final double valeurNote;
  final int coefficientNote;
  final String trimestreNote;

  NoteParent({
    required this.id,
    required this.matriculeEleve,
    required this.nomCompletEleve,
    required this.codeMatiere,
    required this.nomMatiere,
    required this.valeurNote,
    required this.coefficientNote,
    required this.trimestreNote,
  });

  factory NoteParent.fromJson(Map<String, dynamic> json) {
    return NoteParent(
      id: json['id'] ?? 0,
      matriculeEleve: json['matriculeEleve'] ?? '',
      nomCompletEleve: json['nomCompletEleve'] ?? 'Élève inconnu',
      codeMatiere: json['codeMatiere'] ?? '',
      nomMatiere: json['nomMatiere'] ?? 'Matière inconnue',
      valeurNote: (json['valeurNote'] ?? 0).toDouble(),
      coefficientNote: json['coefficientNote'] ?? 1,
      trimestreNote: json['trimestreNote'] ?? 'Trimestre 1',
    );
  }
}