import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/auth/login_page.dart';

// ADMIN
import '../views/admin/dashboard/dashboard_admin.dart';
import '../views/admin/utilisateurs/utilisateurs_page.dart';
import '../views/admin/parents/parents_page.dart';
import '../views/admin/classes/classes_page.dart';
import '../views/admin/matieres/matieres_page.dart';
import '../views/admin/annonces/annonces_page.dart';
import '../views/admin/eleves/eleves_page.dart'
    as admin;

// ENSEIGNANT
import '../views/enseignant/dashboard_enseignant.dart';
import '../views/enseignant/eleves/eleves_page.dart'
    as enseignant;
import '../views/enseignant/notes/notes_page.dart';
import '../views/enseignant/absences/absences_page.dart';
import '../views/enseignant/messages/messages_page.dart';

// PARENT
import '../views/parent/dashboard_parent.dart';
import '../views/parent/notes/notes_parent_page.dart';
import '../views/parent/absences/absences_parent_page.dart';
import '../views/parent/annonces/annonces_parent_page.dart';
import '../views/parent/messages/messages_parent_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/login",
    routes: [

      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginPage(),
      ),

      // ================= ADMIN =================

      GoRoute(
        path: "/admin",
        builder: (context, state) => const DashboardAdmin(),
      ),

      GoRoute(
        path: "/users",
        builder: (context, state) => const UtilisateursPage(),
      ),

      GoRoute(
        path: "/parents",
        builder: (context, state) => const ParentsPage(),
      ),

      GoRoute(
        path: "/eleves",
        builder: (context, state) => const admin.ElevesPage(),
      ),

      GoRoute(
        path: "/classes",
        builder: (context, state) => const ClassesPage(),
      ),

      GoRoute(
        path: "/matieres",
        builder: (context, state) => const MatieresPage(),
      ),

      GoRoute(
        path: "/annonces",
        builder: (context, state) => const AnnoncesPage(),
      ),

      // ================= ENSEIGNANT =================

      GoRoute(
        path: "/enseignant",
        builder: (context, state) =>
            const DashboardEnseignant(),
      ),

      GoRoute(
        path: "/enseignant/eleves",
        builder: (context, state) =>
            const enseignant.ElevesPage(),
      ),

      GoRoute(
        path: "/enseignant/notes",
        builder: (context, state) =>
            const NotesPage(),
      ),

      GoRoute(
        path: "/enseignant/absences",
        builder: (context, state) =>
            const AbsencesPage(),
      ),

      GoRoute(
        path: "/enseignant/messages",
        builder: (context, state) =>
            const MessagesPage(),
      ),

      // ================= PARENT =================

      GoRoute(
        path: "/parent",
        builder: (context, state) =>
            const DashboardParent(),
      ),

      GoRoute(
        path: "/parent/notes",
        builder: (context, state) =>
            const NotesParentPage(),
      ),

      GoRoute(
        path: "/parent/absences",
        builder: (context, state) =>
            const AbsencesParentPage(),
      ),

      GoRoute(
        path: "/parent/annonces",
        builder: (context, state) =>
            const AnnoncesParentPage(),
      ),

      GoRoute(
        path: "/parent/messages",
        builder: (context, state) =>
            const MessagesParentPage(),
      ),

      GoRoute(
        path: "/parent/reponses",
        builder: (context, state) =>
            const MessagesParentPage(),
      ),
    ],
  );
}