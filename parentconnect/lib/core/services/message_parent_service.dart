import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/message_parent.dart';
import 'storage_service.dart';

class MessageParentService {
  final String baseUrl = "http://localhost:3000/api/v1/messages"; 

  // Récupérer les messages envoyés
  Future<List<MessageParent>> getMessages() async {
    try {
      final token = await StorageService.getToken();
      final emailParent = await StorageService.getEmail(); 

      final response = await http.get(
        Uri.parse('$baseUrl/envoyes/$emailParent'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> list = json['messages'] ?? [];
        return list.map((dynamic item) => MessageParent.fromJson(item)).toList();
      } else {
        throw Exception("Impossible de charger les messages (${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Erreur de connexion : $e");
    }
  }

  // Envoyer un nouveau message avec l'email du destinataire dynamique
  Future<bool> envoyerMessage(String emailDestinataire, String contenu) async {
    try {
      final token = await StorageService.getToken();
      final emailParent = await StorageService.getEmail();

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'emailExpediteur': emailParent,
          'emailDestinataire': emailDestinataire, 
          'contenuMessage': contenu,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      throw Exception("Erreur lors de l'envoi : $e");
    }
  }
}