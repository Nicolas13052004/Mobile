// lib/core/services/annonce_parent_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/annonce_parent.dart';
import 'storage_service.dart';

class AnnonceParentService {
  final String baseUrl = "http://localhost:3000/api/v1/annonces"; 

  Future<List<AnnonceParent>> getAnnonces() async {
    try {
      final token = await StorageService.getToken();

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => AnnonceParent.fromJson(item)).toList();
      } else {
        throw Exception("Impossible de charger les annonces (${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Erreur de connexion au serveur : $e");
    }
  }
}