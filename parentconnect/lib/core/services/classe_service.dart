// lib/core/services/classe_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/classe.dart';
import 'storage_service.dart';

class ClasseService {
  final String baseUrl = "http://localhost:3000/api/v1/classes";

  Future<Map<String, String>> _getHeaders() async {
    final token = await StorageService.getToken();
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// GET / - Récupérer toutes les classes (Renvoie une liste d'objets Classe)
  Future<List<Classe>> getAll() async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: await _getHeaders());

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Classe.fromJson(item)).toList();
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? "Erreur de récupération des classes");
      }
    } catch (e) {
      throw Exception("Erreur réseau : $e");
    }
  }

  /// Utilisé spécifiquement pour charger les chaînes de caractères dans les menus déroulants
  Future<List<String>> getNomClasses() async {
    final classes = await getAll();
    return classes.map((c) => c.nomClasse).toList();
  }

  /// POST / - Créer une classe (Admin seul)
  Future<Classe> create(Map<String, dynamic> classeData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await _getHeaders(),
        body: jsonEncode(classeData),
      );

      final result = jsonDecode(response.body);
      if (response.statusCode == 201 && result['success'] == true) {
        return Classe.fromJson(result['data']);
      } else {
        throw Exception(result['message'] ?? "Échec de création de la classe");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// PUT /:id - Modifier une classe (Admin seul)
  Future<Classe> update(int id, Map<String, dynamic> classeData) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await _getHeaders(),
        body: jsonEncode(classeData),
      );

      final result = jsonDecode(response.body);
      if (response.statusCode == 200 && result['success'] == true) {
        return Classe.fromJson(result['data']);
      } else {
        throw Exception(result['message'] ?? "Échec de modification de la classe");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// DELETE /:id - Supprimer une classe (Admin seul)
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