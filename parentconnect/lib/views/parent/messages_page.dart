import 'package:flutter/material.dart';
import '../../controllers/message_controller.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  final controller = MessageController();
  List messages = [];

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future loadMessages() async {
    final data = await controller.getByUser(1); // parent connecté
    setState(() {
      messages = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {

          final m = messages[index];

          return ListTile(
            leading: const Icon(Icons.message),
            title: Text(m['content']),
            subtitle: Text("From: ${m['senderId']}"),
          );
        },
      ),
    );
  }
}