import 'package:flutter/material.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DWM Chatbot",
        style: TextStyle(color: Theme.of(context).indicatorColor),),
      ),
      body: Center(
        child: Text("DWM Chat bot"),
      ),
    );
  }
}
