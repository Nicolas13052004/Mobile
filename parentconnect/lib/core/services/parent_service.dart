import 'dart:convert';

import 'package:http/http.dart'
    as http;

import '../../models/parent_eleve.dart';

import '../config/api_config.dart';
import 'storage_service.dart';

class ParentService {

  Future<List<ParentEleve>>
      getAll() async {

    final token =
        await StorageService.getToken();

    final response =
        await http.get(

      Uri.parse(
        "${ApiConfig.baseUrl}/parents",
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
              ParentEleve.fromJson(e),
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
        "${ApiConfig.baseUrl}/parents",
      ),

      headers: {
        "Authorization":
            "Bearer $token",

        "Content-Type":
            "application/json",
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
        "${ApiConfig.baseUrl}/parents/$id",
      ),

      headers: {
        "Authorization":
            "Bearer $token",

        "Content-Type":
            "application/json",
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
        "${ApiConfig.baseUrl}/parents/$id",
      ),

      headers: {
        "Authorization":
            "Bearer $token",
      },
    );
  }
}