import 'storage_service.dart';

class AuthGuard {

  static Future<bool> isLoggedIn() async {

    final token =
        await StorageService.getToken();

    if (token == null) {
      return false;
    }

    return token.isNotEmpty;
  }

  static Future<String?> getToken()
  async {
    return await StorageService.getToken();
  }

}