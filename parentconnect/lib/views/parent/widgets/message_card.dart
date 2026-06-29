import 'package:flutter/material.dart';
import '../../../models/message_parent.dart';

class MessageCard extends StatelessWidget {
  final MessageParent message;
  final String emailParentConnecte; 

  const MessageCard({
    super.key, 
    required this.message,
    required this.emailParentConnecte,
  });

  // CORRECTION : Prise en charge de l'heure locale (.toLocal())
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

  @override
  Widget build(BuildContext context) {
    final bool estMonMessage = message.emailExpediteur == emailParentConnecte;

    return Align(
      alignment: estMonMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: estMonMessage ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(estMonMessage ? 12 : 0),
            bottomRight: Radius.circular(estMonMessage ? 0 : 12),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              estMonMessage ? "À : ${message.nomDestinataire}" : "De : ${message.nomExpediteur}",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 12,
                color: estMonMessage ? Colors.blue.shade900 : Colors.black87
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.contenuMessage,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formatDisplayDate(message.dateEnvoi), // Utilise la date corrigée locale
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                ),
                if (estMonMessage) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message.luMessage ? Icons.done_all : Icons.done, // Coche double ou simple
                    size: 14,
                    color: message.luMessage ? Colors.green : Colors.grey,
                  )
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}