import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import 'storage_service.dart';

class ApiService {
  Future<Map<String, String>> _headers() async {
    final token =
        await StorageService.getToken();

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(
    String endpoint,
  ) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConfig.baseUrl}$endpoint',
      ),
      headers: await _headers(),
    );

    return jsonDecode(response.body);
  }

  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse(
        '${ApiConfig.baseUrl}$endpoint',
      ),
      headers: await _headers(),
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse(
        '${ApiConfig.baseUrl}$endpoint',
      ),
      headers: await _headers(),
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  Future<dynamic> delete(
    String endpoint,
  ) async {
    final response = await http.delete(
      Uri.parse(
        '${ApiConfig.baseUrl}$endpoint',
      ),
      headers: await _headers(),
    );

    return jsonDecode(response.body);
  }
}