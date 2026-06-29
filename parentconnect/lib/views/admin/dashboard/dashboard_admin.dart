import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/dashboard_stats.dart';
import '../../../core/services/dashboard_service.dart';
import '../../../core/services/storage_service.dart';

class DashboardAdmin
    extends StatefulWidget {

  const DashboardAdmin({
    super.key,
  });

  @override
  State<DashboardAdmin>
      createState() =>
          _DashboardAdminState();
}

class _DashboardAdminState
    extends State<DashboardAdmin> {

  final DashboardService service =
      DashboardService();

  DashboardStats? stats;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadStats();
  }

  Future<void> loadStats() async {

    try {

      final data =
          await service.getStats();

      setState(() {
        stats = data;
        loading = false;
      });

    } catch (e) {

      setState(() {
        loading = false;
      });
    }
  }

  Future<void> logout() async {

    await StorageService.logout();

    if (!mounted) return;

    context.go("/login");
  }

  Widget buildCard(
    String title,
    int value,
    IconData icon,
  ) {

    return Card(

      child: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
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
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              value.toString(),
              style:
                  const TextStyle(
                fontSize: 26,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(
    String label,
    IconData icon,
    String route,
  ) {

    return SizedBox(

      width: double.infinity,

      child: FilledButton.icon(

        onPressed: () {
          context.go(route);
        },

        icon: Icon(icon),

        label: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text(
          "ParentConnect",
        ),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : SingleChildScrollView(

              padding:
                  const EdgeInsets.all(
                20,
              ),

              child: Column(

                children: [

                  GridView.count(

                    crossAxisCount: 2,

                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    children: [

                      buildCard(
                        "Utilisateurs",
                        stats?.utilisateurs ??
                            0,
                        Icons.people,
                      ),

                      buildCard(
                        "Parents",
                        stats?.parents ??
                            0,
                        Icons.family_restroom,
                      ),

                      buildCard(
                        "Élèves",
                        stats?.eleves ??
                            0,
                        Icons.school,
                      ),

                      buildCard(
                        "Classes",
                        stats?.classes ??
                            0,
                        Icons.class_,
                      ),

                      buildCard(
                        "Matières",
                        stats?.matieres ??
                            0,
                        Icons.menu_book,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  buildMenuButton(
                    "Utilisateurs",
                    Icons.people,
                    "/users",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  buildMenuButton(
                    "Parents",
                    Icons.family_restroom,
                    "/parents",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  buildMenuButton(
                    "Élèves",
                    Icons.school,
                    "/eleves",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  buildMenuButton(
                    "Classes",
                    Icons.class_,
                    "/classes",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  buildMenuButton(
                    "Matières",
                    Icons.menu_book,
                    "/matieres",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  buildMenuButton(
                    "Annonces",
                    Icons.campaign,
                    "/annonces",
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  SizedBox(
                    width:
                        double.infinity,

                    child:
                        OutlinedButton.icon(

                      onPressed:
                          logout,

                      icon:
                          const Icon(
                        Icons.logout,
                      ),

                      label:
                          const Text(
                        "Déconnexion",
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}