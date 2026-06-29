// lib/views/parent/notes/notes_parent_page.dart

import 'package:flutter/material.dart';
import '../../../models/note_parent.dart';
import '../../../core/services/note_parent_service.dart';
import '../widgets/note_card.dart';

class NotesParentPage extends StatefulWidget {
  const NotesParentPage({super.key});

  @override
  State<NotesParentPage> createState() => _NotesParentPageState();
}

class _NotesParentPageState extends State<NotesParentPage> {
  final NoteParentService _service = NoteParentService();
  List<NoteParent> _allNotes = [];
  List<NoteParent> _filteredNotes = [];
  
  String _selectedTrimestre = 'Tous';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    setState(() => _isLoading = true);
    try {
      final data = await _service.getNotes();
      setState(() {
        _allNotes = data;
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
      if (_selectedTrimestre == 'Tous') {
        _filteredNotes = _allNotes;
      } else {
        _filteredNotes = _allNotes
            .where((note) => note.trimestreNote == _selectedTrimestre)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bulletins & Notes"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Zone de sélection du filtre de Trimestre
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Filtrer par période :",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      DropdownButton<String>(
                        value: _selectedTrimestre,
                        items: <String>['Tous', 'Trimestre 1', 'Trimestre 2', 'Trimestre 3']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _selectedTrimestre = newValue;
                            _applyFilter();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                
                // Liste des cartes de notes
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _fetchNotes,
                    child: _filteredNotes.isEmpty
                        ? const Center(
                            child: Text(
                              "Aucune note disponible pour cette période.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: _filteredNotes.length,
                            itemBuilder: (context, index) {
                              return NoteCard(note: _filteredNotes[index]);
                            },
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}