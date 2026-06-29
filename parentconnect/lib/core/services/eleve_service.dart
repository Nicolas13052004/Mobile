import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/eleve.dart';
import 'storage_service.dart'; // Importation de ton stockage de token

class EleveService {
  final String baseUrl = "http://localhost:3000/api/v1/eleves";

  /// Génère les headers indispensables de manière asynchrone en récupérant le token
  Future<Map<String, String>> _getHeaders() async {
    final token = await StorageService.getToken();
    
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Récupérer tous les élèves
  Future<List<Eleve>> getAll() async {
    try {
      final headers = await _getHeaders();
      
      // Sécurité : Si le token n'est pas dans les headers, on bloque avant d'appeler le serveur
      if (!headers.containsKey('Authorization')) {
        throw Exception("Utilisateur non authentifié. Token manquant.");
      }

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Eleve.fromJson(item)).toList();
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? "Erreur lors de la récupération des élèves");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Inscrire / Créer un nouvel élève (Admin)
  Future<Eleve> create(Map<String, dynamic> eleveData) async {
    try {
      final headers = await _getHeaders();

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: jsonEncode(eleveData),
      );

      if (response.statusCode == 201) {
        return Eleve.fromJson(jsonDecode(response.body));
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? "Échec de l'inscription");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Modifier les informations d'un élève (Admin)
  Future<Eleve> update(int id, Map<String, dynamic> eleveData) async {
    try {
      final headers = await _getHeaders();

      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: headers,
        body: jsonEncode(eleveData),
      );

      if (response.statusCode == 200) {
        return Eleve.fromJson(jsonDecode(response.body));
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? "Échec de la modification");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Supprimer un élève (Admin)
  Future<void> delete(int id) async {
    try {
      final headers = await _getHeaders();

      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: headers,
      );

      if (response.statusCode != 200) {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? "Échec de la suppression");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}