import 'dart:convert';

import 'package:http/http.dart'
    as http;

import '../../models/note.dart';

import '../config/api_config.dart';
import 'storage_service.dart';

class NoteService {

  Future<Map<String, String>>
      _headers() async {

    final token =
        await StorageService.getToken();

    return {
      "Content-Type":
          "application/json",
      "Authorization":
          "Bearer $token",
    };
  }

  Future<List<Note>> getAll()
  async {

    final response =
        await http.get(
      Uri.parse(
        "${ApiConfig.baseUrl}/notes",
      ),
      headers:
          await _headers(),
    );

    final List data =
        jsonDecode(response.body);

    return data
        .map(
          (e) => Note.fromJson(e),
        )
        .toList();
  }

  Future<void> create(
    Map<String, dynamic> data,
  ) async {

    await http.post(
      Uri.parse(
        "${ApiConfig.baseUrl}/notes",
      ),
      headers:
          await _headers(),
      body: jsonEncode(data),
    );
  }

  Future<void> update(
    int id,
    Map<String, dynamic> data,
  ) async {

    await http.put(
      Uri.parse(
        "${ApiConfig.baseUrl}/notes/$id",
      ),
      headers:
          await _headers(),
      body: jsonEncode(data),
    );
  }

  Future<void> delete(
    int id,
  ) async {

    await http.delete(
      Uri.parse(
        "${ApiConfig.baseUrl}/notes/$id",
      ),
      headers:
          await _headers(),
    );
  }
}