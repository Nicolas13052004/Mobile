import '../core/services/api_service.dart';

class ParentController {

  final ApiService api = ApiService();

  Future getAll() => api.get("/parents");

  Future getById(int id) => api.get("/parents/$id");

  Future create(data) => api.post("/parents", data);

  Future update(int id, data) => api.put("/parents/$id", data);

  Future delete(int id) => api.delete("/parents/$id");
}