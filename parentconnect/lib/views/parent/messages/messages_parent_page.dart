import 'package:flutter/material.dart';
import '../../../models/message_parent.dart';
import '../../../core/services/message_parent_service.dart';
import '../../../core/services/storage_service.dart'; 
import '../widgets/message_card.dart';

class MessagesParentPage extends StatefulWidget {
  const MessagesParentPage({super.key});

  @override
  State<MessagesParentPage> createState() => _MessagesParentPageState();
}

class _MessagesParentPageState extends State<MessagesParentPage> {
  final MessageParentService _service = MessageParentService();
  final _emailDestinataireController = TextEditingController(); 
  final _contenuController = TextEditingController();
  
  List<MessageParent> _messages = [];
  String _myEmail = ""; 
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEmailAndMessages();
  }

  Future<void> _loadEmailAndMessages() async {
    try {
      final email = await StorageService.getEmail();
      setState(() {
        _myEmail = email ?? "";
      });
      await _fetchMessages();
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar("Erreur d'initialisation : $e", Colors.red);
    }
  }

  @override
  void dispose() {
    _emailDestinataireController.dispose();
    _contenuController.dispose();
    super.dispose();
  }

  Future<void> _fetchMessages() async {
    setState(() => _isLoading = true);
    try {
      final data = await _service.getMessages();
      setState(() {
        _messages = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar("Erreur : $e", Colors.red);
    }
  }

  void _showSnackBar(String msg, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: color),
      );
    }
  }

  void _ouvrirDialogueEnvoi() {
    _emailDestinataireController.clear();
    _contenuController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Nouveau message"),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailDestinataireController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email du destinataire (Enseignant/Admin)",
                  hintText: "exemple@ecole.com",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contenuController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Écrivez votre message ici...",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              final emailDest = _emailDestinataireController.text.trim();
              final contenu = _contenuController.text.trim();

              if (emailDest.isEmpty || contenu.isEmpty) {
                _showSnackBar("Veuillez remplir tous les champs", Colors.orange);
                return;
              }
              Navigator.pop(context);
              
              setState(() => _isLoading = true);
              try {
                final success = await _service.envoyerMessage(emailDest, contenu);
                if (success) {
                  _showSnackBar("Message envoyé avec succès !", Colors.green);
                  _fetchMessages();
                } else {
                  throw Exception("Échec de l'envoi");
                }
              } catch (e) {
                setState(() => _isLoading = false);
                _showSnackBar(e.toString(), Colors.red);
              }
            },
            child: const Text("Envoyer"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messagerie"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchMessages,
              child: _messages.isEmpty
                  ? const Center(
                      child: Text(
                        "Aucun message.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return MessageCard(
                          message: _messages[index],
                          emailParentConnecte: _myEmail, 
                        );
                      },
                    ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _ouvrirDialogueEnvoi,
        label: const Text("Nouveau message"),
        icon: const Icon(Icons.send),
        backgroundColor: Colors.blue,
      ),
    );
  }
}