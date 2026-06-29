// lib/models/classe.dart

class Classe {
  final int id;
  final String nomClasse;
  final String? niveauClasse;

  Classe({
    required this.id,
    required this.nomClasse,
    this.niveauClasse,
  });

  factory Classe.fromJson(Map<String, dynamic> json) {
    return Classe(
      id: json['id'] ?? 0,
      nomClasse: json['nomClasse'] ?? '',
      niveauClasse: json['niveauClasse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomClasse': nomClasse,
      'niveauClasse': niveauClasse,
    };
  }
}