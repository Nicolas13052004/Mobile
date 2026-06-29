import '../core/services/api_service.dart';

class UtilisateurController {

  final ApiService api = ApiService();

  Future getAll() => api.get("/users");

  Future create(data) => api.post("/users", data);

  Future update(int id, data) => api.put("/users/$id", data);

  Future delete(int id) => api.delete("/users/$id");
}