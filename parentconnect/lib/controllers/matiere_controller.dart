import '../core/services/api_service.dart';

class MatiereController {

  final ApiService api = ApiService();

  Future getAll() => api.get("/matieres");

  Future getById(int id) => api.get("/matieres/$id");

  Future create(data) => api.post("/matieres", data);

  Future update(int id, data) => api.put("/matieres/$id", data);

  Future delete(int id) => api.delete("/matieres/$id");
}