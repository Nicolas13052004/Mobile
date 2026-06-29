import 'package:flutter/material.dart';
import '../../../models/message.dart';
import '../../../core/services/message_service.dart';
import '../../../core/services/storage_service.dart';
import 'message_form_dialog.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final service = MessageService();
  List<Message> messages = [];
  String currentEmail = '';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Fonction de formatage robuste pour éviter les crashs sur la date
  String formatDisplayDate(dynamic dateField) {
    if (dateField == null) return "";
    final String dateStr = dateField.toString();
    if (dateStr.isEmpty) return "";
    
    try {
      final DateTime parsed = DateTime.parse(dateStr).toLocal();
      return "${parsed.day.toString().padLeft(2, '0')}/${parsed.month.toString().padLeft(2, '0')} à ${parsed.hour}h${parsed.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return dateStr.split('T')[0];
    }
  }

  Future<void> loadData() async {
    try {
      final email = await StorageService.getEmail() ?? '';

      if (email.isEmpty) {
        throw Exception("Aucun email trouvé dans le stockage local.");
      }

      setState(() {
        currentEmail = email;
      });

      final data = await service.getMessagesEnvoyes(email);

      setState(() {
        messages = data;
        loading = false;
      });

      // Automatiquement marquer comme "Lu" si l'enseignant est le destinataire et qu'il est non lu
      for (var msg in data) {
        if (msg.emailDestinataire == email && !msg.luMessage) {
          await service.update(msg.id, {'luMessage': true});
        }
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> sendMessage() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const MessageFormDialog(),
    );

    if (result == null) return;

    final email = await StorageService.getEmail();
    result["emailExpediteur"] = email;

    await service.create(result);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendMessage,
        child: const Icon(Icons.send),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : messages.isEmpty
              ? const Center(child: Text("Aucun message trouvé."))
              : RefreshIndicator(
                  onRefresh: loadData,
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final bool estMonMessage = msg.emailExpediteur == currentEmail;

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: estMonMessage ? Colors.blue.shade50 : Colors.grey.shade100,
                            child: Icon(
                              estMonMessage ? Icons.outbox : Icons.inbox,
                              color: estMonMessage ? Colors.blue : Colors.grey.shade700,
                            ),
                          ),
                          title: Text(
                            estMonMessage ? "À : ${msg.nomDestinataire}" : "De : ${msg.nomExpediteur}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(msg.contenuMessage, style: const TextStyle(color: Colors.black87)),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // Utilisation sécurisée de la date venant du modèle
                                    formatDisplayDate(msg.dateEnvoi),
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                                  ),
                                  if (estMonMessage)
                                    Row(
                                      children: [
                                        Text(
                                          msg.luMessage ? "Lu" : "Distribué",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: msg.luMessage ? Colors.green : Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          msg.luMessage ? Icons.done_all : Icons.done, // Coche double ou simple
                                          size: 16,
                                          color: msg.luMessage ? Colors.green : Colors.grey,
                                        ),
                                      ],
                                    )
                                  else
                                    Text(
                                      msg.luMessage ? "Lu" : "Nouveau",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: msg.luMessage ? FontWeight.normal : FontWeight.bold,
                                        color: msg.luMessage ? Colors.grey : Colors.orange.shade800,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}