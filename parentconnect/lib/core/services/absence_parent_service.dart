// lib/core/services/absence_parent_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/absence_parent.dart';
import 'storage_service.dart';

class AbsenceParentService {
  final String baseUrl = "http://localhost:3000/api/v1/absences"; 

  Future<List<AbsenceParent>> getAbsences() async {
    try {
      final token = await StorageService.getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/parent'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => AbsenceParent.fromJson(item)).toList();
      } else {
        throw Exception("Impossible de charger les absences (${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Erreur de connexion au serveur : $e");
    }
  }
}