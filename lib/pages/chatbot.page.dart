import 'package:flutter/material.dart';

class ChatBotPage extends StatefulWidget {
  ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  var messages = [
    {"type": "user", "content": "Hello"},
    {"type": "assistant", "content": "How can I help you?"},
  ];

  TextEditingController userQuestion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DWM Chatbot",
        style: TextStyle(color: Theme.of(context).indicatorColor)
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pop;
            Navigator.pushNamed(context, '/');
          },
              icon: Icon(Icons.logout),
              color: Theme.of(context).indicatorColor)
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      messages[index]["type"] == "user"
                          ? SizedBox(width: 80)
                          : SizedBox(width: 0),
                      Expanded(
                        child: Card.outlined(
                          margin: EdgeInsets.all(6),
                          color: messages[index]['type'] == "user" ? Color.fromARGB(40, 0, 255, 0) : Colors.white,
                          child: ListTile(
                            title: Text("${messages[index]['content']}"),
                          ),
                        ),
                      ),
                      messages[index]["type"] == "assistant"
                          ? SizedBox(width: 80)
                          : SizedBox(width: 0),
                    ],
                  ),
                  Divider()
                ],
              );
            },
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: userQuestion,
                    decoration: InputDecoration(
                      hintText: "Ask chatbot...",
                      suffixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor
                        )
                      )
                    ),
                  ),
                ),
                IconButton(onPressed: () {
                  String question = userQuestion.text;
                  String answer = "Answer to ${question}";
                  setState(() {
                    messages.add({"type": "user", "content": question});
                    messages.add({"type": "assistant", "content": answer});
                  });
                },
                  icon: Icon(Icons.send )
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
