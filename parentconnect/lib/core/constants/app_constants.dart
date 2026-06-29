class AppConstants {
  AppConstants._();

  // =========================
  // APP
  // =========================

  static const String appName = 'ParentConnect';

  // =========================
  // ROLES
  // =========================

  static const String admin = 'admin';
  static const String enseignant = 'enseignant';
  static const String parent = 'parent';
  static const String eleve = 'eleve';

  // =========================
  // STORAGE KEYS
  // =========================

  static const String tokenKey = 'token';
  static const String userKey = 'user';

  // =========================
  // MESSAGES
  // =========================

  static const String serverError =
      'Erreur serveur';

  static const String networkError =
      'Connexion impossible';

  static const String loginError =
      'Email ou mot de passe incorrect';

  static const String unauthorized =
      'Accès refusé';

  // =========================
  // TITRES
  // =========================

  static const String dashboardAdmin =
      'Tableau de bord Admin';

  static const String dashboardParent =
      'Tableau de bord Parent';

  static const String dashboardEnseignant =
      'Tableau de bord Enseignant';

  static const String dashboardEleve =
      'Tableau de bord Élève';
}