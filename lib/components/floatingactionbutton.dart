import 'package:flutter/material.dart';
import 'package:datastructure/pages/chatbotpage.dart';

class MyActionButton extends StatelessWidget {
  const MyActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF0C8159),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ChatBotPage()),
        );
      },
      child: const Icon(Icons.smart_toy, size: 28),
    );
  }
}
