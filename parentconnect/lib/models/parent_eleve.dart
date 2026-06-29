class ParentEleve {

  final int id;

  final String emailParent;
  final String nomParent;

  final String matriculeEleve;
  final String nomEleve;

  ParentEleve({
    required this.id,
    required this.emailParent,
    required this.nomParent,
    required this.matriculeEleve,
    required this.nomEleve,
  });

  factory ParentEleve.fromJson(
    Map<String, dynamic> json,
  ) {
    return ParentEleve(
      id: json["id"],

      emailParent:
          json["emailParent"] ?? "",

      nomParent:
          json["nomParent"] ?? "",

      matriculeEleve:
          json["matriculeEleve"] ?? "",

      nomEleve:
          json["nomEleve"] ?? "",
    );
  }
}