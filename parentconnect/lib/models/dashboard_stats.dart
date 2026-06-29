class DashboardStats {

  final int utilisateurs;
  final int eleves;
  final int parents;
  final int classes;
  final int matieres;

  DashboardStats({
    required this.utilisateurs,
    required this.eleves,
    required this.parents,
    required this.classes,
    required this.matieres,
  });

  factory DashboardStats.fromJson(
    Map<String, dynamic> json,
  ) {

    return DashboardStats(

      utilisateurs:
          json["utilisateurs"] ?? 0,

      eleves:
          json["eleves"] ?? 0,

      parents:
          json["parents"] ?? 0,

      classes:
          json["classes"] ?? 0,

      matieres:
          json["matieres"] ?? 0,
    );
  }
}