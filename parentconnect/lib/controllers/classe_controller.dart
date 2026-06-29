import '../core/services/api_service.dart';

class ClasseController {

  final ApiService api = ApiService();

  Future getAll() => api.get("/classes");

  Future getById(int id) => api.get("/classes/$id");

  Future create(data) => api.post("/classes", data);

  Future update(int id, data) => api.put("/classes/$id", data);

  Future delete(int id) => api.delete("/classes/$id");
}