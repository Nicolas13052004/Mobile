import '../core/services/api_service.dart';

class EleveController {

  final ApiService api = ApiService();

  Future getAll() => api.get("/eleves");

  Future getById(int id) => api.get("/eleves/$id");

  Future create(data) => api.post("/eleves", data);

  Future update(int id, data) => api.put("/eleves/$id", data);

  Future delete(int id) => api.delete("/eleves/$id");
}