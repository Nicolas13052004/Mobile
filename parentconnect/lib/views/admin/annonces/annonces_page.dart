import 'package:flutter/material.dart';

import '../../../models/annonce.dart';
import '../../../core/services/annonce_service.dart';

import 'annonce_form_dialog.dart';

class AnnoncesPage
    extends StatefulWidget {

  const AnnoncesPage({
    super.key,
  });

  @override
  State<AnnoncesPage>
      createState() =>
          _AnnoncesPageState();
}

class _AnnoncesPageState
    extends State<AnnoncesPage> {

  final service =
      AnnonceService();

  List<Annonce> annonces = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData()
  async {

    final data =
        await service.getAll();

    setState(() {
      annonces = data;
      loading = false;
    });
  }

  Future<void> addAnnonce()
  async {

    final result =
        await showDialog(
      context: context,
      builder: (_) =>
          const AnnonceFormDialog(),
    );

    if (result == null) return;

    await service.create(result);

    loadData();
  }

  Future<void> editAnnonce(
    Annonce annonce,
  ) async {

    final result =
        await showDialog(
      context: context,
      builder: (_) =>
          AnnonceFormDialog(
        annonce: {
          "titreAnnonce":
              annonce.titreAnnonce,
          "contenuAnnonce":
              annonce.contenuAnnonce,
        },
      ),
    );

    if (result == null) return;

    await service.update(
      annonce.id,
      result,
    );

    loadData();
  }

  Future<void> deleteAnnonce(
    Annonce annonce,
  ) async {

    await service.delete(
      annonce.id,
    );

    loadData();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Annonces",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed:
            addAnnonce,
        child:
            const Icon(Icons.add),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : ListView.builder(
              itemCount:
                  annonces.length,

              itemBuilder:
                  (context, index) {

                final annonce =
                    annonces[index];

                return Card(

                  margin:
                      const EdgeInsets.all(
                    8,
                  ),

                  child: ListTile(

                    title: Text(
                      annonce.titreAnnonce.isEmpty
                          ? "Sans titre"
                          : annonce.titreAnnonce,
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          annonce.contenuAnnonce.isEmpty
                              ? "-"
                              : annonce.contenuAnnonce,
                        ),

                        if (annonce.datePublication !=
                            null)
                          Text(
                            annonce.datePublication!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),

                    trailing: Row(
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        IconButton(
                          icon:
                              const Icon(
                            Icons.edit,
                          ),

                          onPressed: () {
                            editAnnonce(
                              annonce,
                            );
                          },
                        ),

                        IconButton(
                          icon:
                              const Icon(
                            Icons.delete,
                          ),

                          onPressed: () {
                            deleteAnnonce(
                              annonce,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}