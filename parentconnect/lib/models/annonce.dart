class Annonce {
  final int id;

  final String titreAnnonce;
  final String contenuAnnonce;
  final String? datePublication;

  Annonce({
    required this.id,
    required this.titreAnnonce,
    required this.contenuAnnonce,
    this.datePublication,
  });

  factory Annonce.fromJson(
    Map<String, dynamic> json,
  ) {
    return Annonce(
      id: json["id"] ?? 0,

      titreAnnonce:
          (json["titreAnnonce"] ?? "")
              .toString(),

      contenuAnnonce:
          (json["contenuAnnonce"] ?? "")
              .toString(),

      datePublication:
          json["datePublication"]
              ?.toString(),
    );
  }
}