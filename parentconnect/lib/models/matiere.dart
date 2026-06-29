// lib/models/matiere.dart

class Matiere {
  final int id;
  final String nomMatiere;
  final String? codeMatiere;

  Matiere({
    required this.id,
    required this.nomMatiere,
    this.codeMatiere,
  });

  factory Matiere.fromJson(Map<String, dynamic> json) {
    return Matiere(
      id: json['id'] ?? 0,
      nomMatiere: json['nomMatiere'] ?? '',
      codeMatiere: json['codeMatiere'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomMatiere': nomMatiere,
      'codeMatiere': codeMatiere,
    };
  }
}