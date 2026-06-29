// lib/views/parent/absences/absences_parent_page.dart

import 'package:flutter/material.dart';
import '../../../models/absence_parent.dart';
import '../../../core/services/absence_parent_service.dart';
import '../widgets/absence_card.dart';

class AbsencesParentPage extends StatefulWidget {
  const AbsencesParentPage({super.key});

  @override
  State<AbsencesParentPage> createState() => _AbsencesParentPageState();
}

class _AbsencesParentPageState extends State<AbsencesParentPage> {
  final AbsenceParentService _service = AbsenceParentService();
  List<AbsenceParent> _allAbsences = [];
  List<AbsenceParent> _filteredAbsences = [];
  
  String _filterStatus = 'Toutes';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAbsences();
  }

  Future<void> _fetchAbsences() async {
    setState(() => _isLoading = true);
    try {
      final data = await _service.getAbsences();
      setState(() {
        _allAbsences = data;
        _isLoading = false;
      });
      _applyFilter();
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _applyFilter() {
    setState(() {
      if (_filterStatus == 'Toutes') {
        _filteredAbsences = _allAbsences;
      } else if (_filterStatus == 'Justifiées') {
        _filteredAbsences = _allAbsences.where((abs) => abs.estJustifie).toList();
      } else {
        _filteredAbsences = _allAbsences.where((abs) => !abs.estJustifie).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suivi des Absences"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Zone des filtres de statut
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Statut des absences :",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      DropdownButton<String>(
                        value: _filterStatus,
                        items: <String>['Toutes', 'Justifiées', 'Non justifiées']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _filterStatus = newValue;
                            _applyFilter();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                
                // Liste finale
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _fetchAbsences,
                    child: _filteredAbsences.isEmpty
                        ? const Center(
                            child: Text(
                              "Aucune absence enregistrée pour le moment.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: _filteredAbsences.length,
                            itemBuilder: (context, index) {
                              return AbsenceCard(absence: _filteredAbsences[index]);
                            },
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}