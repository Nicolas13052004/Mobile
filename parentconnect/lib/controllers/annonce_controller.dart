import '../core/services/api_service.dart';

class AnnonceController {

  final ApiService api = ApiService();

  Future getAll() =>
      api.get("/annonces");

  Future create(data) =>
      api.post("/annonces", data);
}