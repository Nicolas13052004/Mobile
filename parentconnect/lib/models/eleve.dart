class Eleve {
  final int id;
  final String matriculeEleve; // Ajouté ici
  final String nomEleve;
  final String prenomEleve;
  final String dateNaissanceEleve;
  final String nomClasseEleve; 
  final int? parentId;

  Eleve({
    required this.id,
    required this.matriculeEleve,
    required this.nomEleve,
    required this.prenomEleve,
    required this.dateNaissanceEleve,
    required this.nomClasseEleve,
    this.parentId,
  });

  factory Eleve.fromJson(Map<String, dynamic> json) {
    return Eleve(
      id: json['id'] ?? 0,
      matriculeEleve: json['matriculeEleve'] ?? '', // Ajouté ici
      nomEleve: json['nomEleve'] ?? '',
      prenomEleve: json['prenomEleve'] ?? '',
      dateNaissanceEleve: json['dateNaissanceEleve'] ?? '',
      nomClasseEleve: json['nomClasseEleve'] ?? '',
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matriculeEleve': matriculeEleve, // Ajouté ici
      'nomEleve': nomEleve,
      'prenomEleve': prenomEleve,
      'dateNaissanceEleve': dateNaissanceEleve,
      'nomClasseEleve': nomClasseEleve,
      'parentId': parentId,
    };
  }
}