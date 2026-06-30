import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/message.dart';
import 'storage_service.dart';

class MessageService {
  // Ajuste l'adresse IP ou le port si nécessaire selon ta configuration Backend
  final String baseUrl = "http://mobile-sofm.onrender.com/api/v1/messages"; 

  // Récupérer l'historique des messages (envoyés et reçus)
  Future<List<Message>> getMessagesEnvoyes(String email) async {
    try {
      final token = await StorageService.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/envoyes/$email'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> list = json['messages'] ?? [];
        return list.map((dynamic item) => Message.fromJson(item)).toList();
      } else {
        throw Exception("Impossible de charger les messages");
      }
    } catch (e) {
      throw Exception("Erreur de connexion : $e");
    }
  }

  // Créer / Envoyer un nouveau message
  Future<bool> create(Map<String, dynamic> data) async {
    try {
      final token = await StorageService.getToken();
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  // Mettre à jour le statut du message (ex: marquer comme lu)
  Future<bool> update(int id, Map<String, dynamic> data) async {
    try {
      final token = await StorageService.getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}