import 'dart:convert';

import 'package:http/http.dart'
    as http;

import '../config/api_config.dart';
import '../services/storage_service.dart';

import '../../models/dashboard_stats.dart';

class DashboardService {

  Future<DashboardStats>
      getStats() async {

    final token =
        await StorageService.getToken();

    final response =
        await http.get(

      Uri.parse(
        "${ApiConfig.baseUrl}/dashboard/stats",
      ),

      headers: {
        "Authorization":
            "Bearer $token",
      },
    );

    if (response.statusCode == 200) {

      return DashboardStats.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception(
      "Erreur chargement dashboard",
    );
  }
}