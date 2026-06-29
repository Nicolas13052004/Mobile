// lib/core/services/note_parent_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/note_parent.dart';
import 'storage_service.dart';

class NoteParentService {
  // Remplace par ton URL réseau locale ou globale
  final String baseUrl = "http://localhost:3000/api/v1/notes"; 

  Future<List<NoteParent>> getNotes() async {
    try {
      final token = await StorageService.getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/parent'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => NoteParent.fromJson(item)).toList();
      } else {
        throw Exception("Impossible de charger les notes (${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Erreur de connexion au serveur : $e");
    }
  }
}