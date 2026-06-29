class Utilisateur {

  final int id;

  final String nomUtilisateur;
  final String prenomUtilisateur;
  final String emailUtilisateur;
  final String roleUtilisateur;

  Utilisateur({
    required this.id,
    required this.nomUtilisateur,
    required this.prenomUtilisateur,
    required this.emailUtilisateur,
    required this.roleUtilisateur,
  });

  factory Utilisateur.fromJson(
    Map<String, dynamic> json,
  ) {
    return Utilisateur(
      id: json["id"],

      nomUtilisateur:
          json["nomUtilisateur"] ?? "",

      prenomUtilisateur:
          json["prenomUtilisateur"] ?? "",

      emailUtilisateur:
          json["emailUtilisateur"] ?? "",

      roleUtilisateur:
          json["roleUtilisateur"] ?? "",
    );
  }
}