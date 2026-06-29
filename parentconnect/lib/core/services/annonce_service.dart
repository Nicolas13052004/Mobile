import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/annonce.dart';
import '../config/api_config.dart';
import 'storage_service.dart';

class AnnonceService {

  Future<Map<String, String>> _headers()
  async {

    final token =
        await StorageService.getToken();

    return {
      "Content-Type":
          "application/json",
      "Authorization":
          "Bearer $token",
    };
  }

  Future<List<Annonce>> getAll() async {
  final response = await http.get(
    Uri.parse(
      "${ApiConfig.baseUrl}/annonces",
    ),
    headers: await _headers(),
  );

  if (response.statusCode != 200) {
    throw Exception(
      "Erreur chargement annonces",
    );
  }

  final decoded =
      jsonDecode(response.body);

  List data = [];

  if (decoded is List) {
    data = decoded;
  }

  return data
      .map(
        (e) => Annonce.fromJson(e),
      )
      .toList();
}

  Future<void> create(
    Map<String, dynamic> data,
  ) async {

    await http.post(
      Uri.parse(
        "${ApiConfig.baseUrl}/annonces",
      ),
      headers: await _headers(),
      body: jsonEncode(data),
    );
  }

  Future<void> update(
    int id,
    Map<String, dynamic> data,
  ) async {

    await http.put(
      Uri.parse(
        "${ApiConfig.baseUrl}/annonces/$id",
      ),
      headers: await _headers(),
      body: jsonEncode(data),
    );
  }

  Future<void> delete(
    int id,
  ) async {

    await http.delete(
      Uri.parse(
        "${ApiConfig.baseUrl}/annonces/$id",
      ),
      headers: await _headers(),
    );
  }
}