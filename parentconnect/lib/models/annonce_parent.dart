// lib/models/annonce_parent.dart

class AnnonceParent {
  final int id;
  final String titreAnnonce;
  final String contenuAnnonce;
  final String datePublication;

  AnnonceParent({
    required this.id,
    required this.titreAnnonce,
    required this.contenuAnnonce,
    required this.datePublication,
  });

  factory AnnonceParent.fromJson(Map<String, dynamic> json) {
    return AnnonceParent(
      id: json['id'] ?? 0,
      titreAnnonce: json['titreAnnonce'] ?? 'Sans titre',
      contenuAnnonce: json['contenuAnnonce'] ?? '',
      datePublication: json['datePublication'] ?? '',
    );
  }
}