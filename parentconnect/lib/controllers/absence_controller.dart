import '../core/services/api_service.dart';

class AbsenceController {

  final ApiService api = ApiService();

  Future getByEleve(int id) =>
      api.get("/absences/eleve/$id");

  Future create(data) =>
      api.post("/absences", data);
}