import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/eleve_enseignant.dart';
import '../config/api_config.dart';
import 'storage_service.dart';

class EleveEnseignantService {

  Future<Map<String, String>> _headers() async {

    final token =
        await StorageService.getToken();

    return {

      "Content-Type":
          "application/json",

      "Authorization":
          "Bearer $token",

    };
  }

  Future<List<EleveEnseignant>>
      getAll() async {

    final response = await http.get(

      Uri.parse(
        "${ApiConfig.baseUrl}/eleves",
      ),

      headers: await _headers(),

    );

    if (response.statusCode != 200) {

      throw Exception(
        "Impossible de récupérer les élèves.",
      );

    }

    final List data =
        jsonDecode(response.body);

    return data

        .map(
          (e) =>
              EleveEnseignant.fromJson(e),
        )

        .toList();
  }

}