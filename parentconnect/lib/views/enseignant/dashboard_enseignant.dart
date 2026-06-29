import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/storage_service.dart';

class DashboardEnseignant extends StatelessWidget {
  const DashboardEnseignant({
    super.key,
  });

  Future<void> logout(
    BuildContext context,
  ) async {
    await StorageService.logout();

    if (context.mounted) {
      context.go('/login');
    }
  }

  Widget menuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Espace Enseignant",
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            menuCard(
              icon: Icons.groups,
              title: "Mes Élèves",
              onTap: () {
                context.go(
                  "/enseignant/eleves",
                );
              },
            ),
            menuCard(
              icon: Icons.grade,
              title: "Notes",
              onTap: () {
                context.go(
                  "/enseignant/notes",
                );
              },
            ),
            menuCard(
              icon: Icons.event_busy,
              title: "Absences",
              onTap: () {
                context.go(
                  "/enseignant/absences",
                );
              },
            ),
            menuCard(
              icon: Icons.message,
              title: "Messages",
              onTap: () {
                context.go(
                  "/enseignant/messages",
                );
              },
            ),
            menuCard(
              icon: Icons.campaign,
              title: "Annonces",
              onTap: () {
                context.go(
                  "/annonces",
                );
              },
            ),
            menuCard(
              icon: Icons.logout,
              title: "Déconnexion",
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}