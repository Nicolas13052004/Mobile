import '../core/services/api_service.dart';

class NoteController {

  final ApiService api = ApiService();

  Future getByEleve(int id) =>
      api.get("/notes/eleve/$id");

  Future create(data) =>
      api.post("/notes", data);
}