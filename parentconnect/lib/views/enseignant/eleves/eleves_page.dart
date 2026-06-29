import 'package:flutter/material.dart';

import '../../../core/services/eleve_enseignant_service.dart';
import '../../../models/eleve_enseignant.dart';
import '../widgets/eleve_card.dart';

class ElevesPage extends StatefulWidget {
  const ElevesPage({
    super.key,
  });

  @override
  State<ElevesPage> createState() =>
      _ElevesPageState();
}

class _ElevesPageState
    extends State<ElevesPage> {
  final EleveEnseignantService service =
      EleveEnseignantService();

  final TextEditingController
      searchController =
      TextEditingController();

  List<EleveEnseignant> eleves = [];

  List<EleveEnseignant> filtered = [];

  bool loading = true;

  String erreur = "";

  @override
  void initState() {
    super.initState();

    loadData();

    searchController.addListener(() {
      rechercher(
        searchController.text,
      );
    });
  }

  Future<void> loadData() async {
    try {
      setState(() {
        loading = true;
        erreur = "";
      });

      final data =
          await service.getAll();

      setState(() {
        eleves = data;
        filtered = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        erreur = e.toString();
        loading = false;
      });
    }
  }

  void rechercher(
    String value,
  ) {
    final keyword =
        value.toLowerCase();

    setState(() {
      filtered = eleves.where((e) {
        return e.nomEleve
                .toLowerCase()
                .contains(keyword) ||
            e.prenomEleve
                .toLowerCase()
                .contains(keyword) ||
            e.matriculeEleve
                .toLowerCase()
                .contains(keyword) ||
            e.nomClasseEleve
                .toLowerCase()
                .contains(keyword);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Liste des élèves",
        ),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : erreur.isNotEmpty

              ? Center(
                  child: Text(
                    erreur,
                  ),
                )

              : RefreshIndicator(
                  onRefresh:
                      loadData,

                  child: Column(
                    children: [

                      Padding(
                        padding:
                            const EdgeInsets.all(
                          10,
                        ),

                        child:
                            TextField(
                          controller:
                              searchController,

                          decoration:
                              const InputDecoration(
                            hintText:
                                "Rechercher un élève",

                            prefixIcon:
                                Icon(
                              Icons.search,
                            ),

                            border:
                                OutlineInputBorder(),
                          ),
                        ),
                      ),

                      Expanded(
                        child:
                            filtered.isEmpty

                                ? const Center(
                                    child: Text(
                                      "Aucun élève trouvé",
                                    ),
                                  )

                                : ListView.builder(
                                    itemCount:
                                        filtered.length,

                                    itemBuilder:
                                        (
                                      context,
                                      index,
                                    ) {
                                      return EleveCard(
                                        eleve:
                                            filtered[
                                                index],
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),
                ),
    );
  }
}