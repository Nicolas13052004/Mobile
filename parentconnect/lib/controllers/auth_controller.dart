import 'dart:convert';

import 'package:http/http.dart'
    as http;

import '../core/config/api_config.dart';

class AuthController {

  Future<Map<String, dynamic>>
      login({

    required String email,

    required String password,

  }) async {

    final response =
        await http.post(

      Uri.parse(
        "${ApiConfig.baseUrl}/auth/login",
      ),

      headers: {

        "Content-Type":
            "application/json",

      },

      body: jsonEncode({

        "email": email,

        "password": password,

      }),
    );

    if (response.statusCode == 200) {

      return jsonDecode(
        response.body,
      );
    }

    throw Exception(
      "Email ou mot de passe incorrect",
    );
  }
}