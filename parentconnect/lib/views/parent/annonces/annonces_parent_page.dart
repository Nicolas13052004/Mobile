// lib/views/parent/annonces/annonces_parent_page.dart

import 'package:flutter/material.dart';
import '../../../models/annonce_parent.dart';
import '../../../core/services/annonce_parent_service.dart';
import '../widgets/annonce_card.dart';

class AnnoncesParentPage extends StatefulWidget {
  const AnnoncesParentPage({super.key});

  @override
  State<AnnoncesParentPage> createState() => _AnnoncesParentPageState();
}

class _AnnoncesParentPageState extends State<AnnoncesParentPage> {
  final AnnonceParentService _service = AnnonceParentService();
  List<AnnonceParent> _annonces = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAnnonces();
  }

  Future<void> _fetchAnnonces() async {
    setState(() => _isLoading = true);
    try {
      final data = await _service.getAnnonces();
      setState(() {
        _annonces = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Annonces de l'Établissement"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchAnnonces,
              child: _annonces.isEmpty
                  ? const Center(
                      child: Text(
                        "Aucune annonce publiée pour le moment.",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      itemCount: _annonces.length,
                      itemBuilder: (context, index) {
                        return AnnonceCard(annonce: _annonces[index]);
                      },
                    ),
            ),
    );
  }
}