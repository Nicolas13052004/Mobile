import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'storage_service.dart'; // Importation nécessaire pour sauvegarder le token

class AuthService {

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          "${ApiConfig.baseUrl}/auth/login",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email, // Ajuste en "emailUtilisateur" si ton backend l'exige
          "password": password,
        }),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      // 🔥 SAUVEGARDE DU TOKEN ET DU RÔLE SI LA CONNEXION EST REUSSIE
      // On vérifie le code 200 (ou la présence du token dans la réponse)
      if (response.statusCode == 200 && data['token'] != null) {
        await StorageService.saveToken(data['token']);
        
        // Sauvegarde du rôle si ton backend le renvoie (ex: data['user']['roleUtilisateur'] ou data['role'])
        if (data['role'] != null) {
          await StorageService.saveRole(data['role']);
        } else if (data['user'] != null && data['user']['roleUtilisateur'] != null) {
          await StorageService.saveRole(data['user']['roleUtilisateur']);
        }
      }

      return data;
    } catch (e) {
      throw Exception("Erreur lors de la connexion : $e");
    }
  }
}