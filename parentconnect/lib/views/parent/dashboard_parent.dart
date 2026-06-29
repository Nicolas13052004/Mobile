import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/storage_service.dart';

class DashboardParent extends StatelessWidget {
  const DashboardParent({
    super.key,
  });

  Future<void> logout(BuildContext context) async {
    await StorageService.logout();

    if (context.mounted) {
      context.go("/login");
    }
  }

  Widget menuCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    Color? color,
  }) {
    return Card(
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.go(route);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [

              Icon(
                icon,
                size: 50,
                color: color ??
                    Colors.blue,
              ),

              const SizedBox(height: 15),

              Text(
                title,
                textAlign:
                    TextAlign.center,
                style:
                    const TextStyle(
                  fontSize: 17,
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
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Espace Parent",
        ),

        actions: [

          IconButton(

            onPressed: () {
              logout(context);
            },

            icon: const Icon(
              Icons.logout,
            ),

          )

        ],

      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: GridView.count(

          crossAxisCount: 2,

          crossAxisSpacing: 20,

          mainAxisSpacing: 20,

          children: [

            menuCard(

              context: context,

              icon:
                  Icons.school,

              title:
                  "Notes",

              route:
                  "/parent/notes",

              color:
                  Colors.green,

            ),

            menuCard(

              context: context,

              icon:
                  Icons.event_busy,

              title:
                  "Absences",

              route:
                  "/parent/absences",

              color:
                  Colors.red,

            ),

            menuCard(

              context: context,

              icon:
                  Icons.campaign,

              title:
                  "Annonces",

              route:
                  "/parent/annonces",

              color:
                  Colors.orange,

            ),

            menuCard(

              context: context,

              icon:
                  Icons.message,

              title:
                  "Messages",

              route:
                  "/parent/messages",

              color:
                  Colors.blue,

            ),

            menuCard(

              context: context,

              icon:
                  Icons.mark_email_read,

              title:
                  "Réponses",

              route:
                  "/parent/reponses",

              color:
                  Colors.purple,

            ),

          ],

        ),

      ),

    );

  }

}