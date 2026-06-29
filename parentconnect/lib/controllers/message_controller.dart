import '../core/services/api_service.dart';

class MessageController {

  final ApiService api = ApiService();

  Future send(data) =>
      api.post("/messages", data);

  Future getByUser(int id) =>
      api.get("/messages/$id");
}