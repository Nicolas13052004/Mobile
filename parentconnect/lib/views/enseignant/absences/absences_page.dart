import 'package:flutter/material.dart';

import '../../../models/absence.dart';

import '../../../core/services/absence_service.dart';

import 'absence_form_dialog.dart';

class AbsencesPage
    extends StatefulWidget {

  const AbsencesPage({
    super.key,
  });

  @override
  State<AbsencesPage>
      createState() =>
          _AbsencesPageState();
}

class _AbsencesPageState
    extends State<AbsencesPage> {

  final service =
      AbsenceService();

  List<Absence> absences = [];

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
      absences = data;
      loading = false;
    });
  }

  Future<void> addAbsence()
  async {

    final result =
        await showDialog(
      context: context,
      builder: (_) =>
          const AbsenceFormDialog(),
    );

    if (result == null) return;

    await service.create(
      result,
    );

    loadData();
  }

  Future<void> editAbsence(
    Absence absence,
  ) async {

    final result =
        await showDialog(
      context: context,
      builder: (_) =>
          AbsenceFormDialog(
        absence: {
          "matriculeEleve":
              absence.matriculeEleve,

          "dateAbsence":
              absence.dateAbsence,

          "motifAbsence":
              absence.motifAbsence,
        },
      ),
    );

    if (result == null) return;

    await service.update(
      absence.id,
      result,
    );

    loadData();
  }

  Future<void> deleteAbsence(
    Absence absence,
  ) async {

    await service.delete(
      absence.id,
    );

    loadData();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text(
          "Absences",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed:
            addAbsence,
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
                  absences.length,

              itemBuilder:
                  (_, index) {

                final absence =
                    absences[index];

                return Card(

                  child: ListTile(

                    leading:
                        const Icon(
                      Icons.event_busy,
                    ),

                    title: Text(
                      absence
                          .nomCompletEleve,
                    ),

                    subtitle: Text(
                      "${absence.dateAbsence}\n${absence.motifAbsence}",
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
                          onPressed:
                              () {
                            editAbsence(
                              absence,
                            );
                          },
                        ),

                        IconButton(
                          icon:
                              const Icon(
                            Icons.delete,
                          ),
                          onPressed:
                              () {
                            deleteAbsence(
                              absence,
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