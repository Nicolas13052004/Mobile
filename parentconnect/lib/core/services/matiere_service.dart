// lib/core/services/matiere_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/matiere.dart';
import 'storage_service.dart';

class MatiereService {
  final String baseUrl = "http://localhost:3000/api/v1/matieres";

  Future<Map<String, String>> _getHeaders() async {
    final token = await StorageService.getToken();
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// GET / - Récupérer toutes les matières
  Future<List<Matiere>> getAll() async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: await _getHeaders());

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Matiere.fromJson(item)).toList();
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? "Erreur de récupération des matières");
      }
    } catch (e) {
      throw Exception("Erreur réseau : $e");
    }
  }

  /// POST / - Créer une matière (Admin)
  Future<Matiere> create(Map<String, dynamic> matiereData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await _getHeaders(),
        body: jsonEncode(matiereData),
      );

      final result = jsonDecode(response.body);
      if (response.statusCode == 201 && result['success'] == true) {
        return Matiere.fromJson(result['data']);
      } else {
        throw Exception(result['message'] ?? "Échec de création de la matière");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// PUT /:id - Modifier une matière (Admin)
  Future<Matiere> update(int id, Map<String, dynamic> matiereData) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await _getHeaders(),
        body: jsonEncode(matiereData),
      );

      final result = jsonDecode(response.body);
      if (response.statusCode == 200 && result['success'] == true) {
        return Matiere.fromJson(result['data']);
      } else {
        throw Exception(result['message'] ?? "Échec de modification");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// DELETE /:id - Supprimer une matière (Admin)
  Future<void> delete(int id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"), headers: await _getHeaders());
      final result = jsonDecode(response.body);

      if (response.statusCode != 200 || result['success'] != true) {
        throw Exception(result['message'] ?? "Échec de suppression");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}