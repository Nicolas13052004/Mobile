import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/utilisateur.dart';
import '../config/api_config.dart';
import 'storage_service.dart';

class UtilisateurService {

  Future<List<Utilisateur>>
      getAll() async {

    final token =
        await StorageService.getToken();

    final response = await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/users",
      ),

      headers: {
        "Authorization":
            "Bearer $token",
      },
    );

    final List data =
        jsonDecode(response.body);

    return data
        .map(
          (e) =>
              Utilisateur.fromJson(e),
        )
        .toList();
  }

  Future<void> create(
    Map<String, dynamic> data,
  ) async {

    final token =
        await StorageService.getToken();

    await http.post(
      Uri.parse(
        "${ApiConfig.baseUrl}/users",
      ),

      headers: {
        "Content-Type":
            "application/json",

        "Authorization":
            "Bearer $token",
      },

      body: jsonEncode(data),
    );
  }

  Future<void> update(
    int id,
    Map<String, dynamic> data,
  ) async {

    final token =
        await StorageService.getToken();

    await http.put(
      Uri.parse(
        "${ApiConfig.baseUrl}/users/$id",
      ),

      headers: {
        "Content-Type":
            "application/json",

        "Authorization":
            "Bearer $token",
      },

      body: jsonEncode(data),
    );
  }

  Future<void> delete(
    int id,
  ) async {

    final token =
        await StorageService.getToken();

    await http.delete(
      Uri.parse(
        "${ApiConfig.baseUrl}/users/$id",
      ),

      headers: {
        "Authorization":
            "Bearer $token",
      },
    );
  }
}