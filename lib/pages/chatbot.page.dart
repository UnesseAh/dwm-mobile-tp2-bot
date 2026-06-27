import 'dart:convert';

import 'package:flutter/material.dart';
import  'package:http/http.dart' as http;

class ChatBotPage extends StatefulWidget {
  ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  var messages = [];

  TextEditingController userQuestion = TextEditingController();
  ScrollController scrollController = ScrollController();

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
            Navigator.of(context).pop();
            Navigator.pushNamed(context, '/');
          },
              icon: Icon(Icons.logout),
              color: Theme.of(context).indicatorColor)
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            controller: scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      messages[index]["role"] == "user"
                          ? SizedBox(width: 80)
                          : SizedBox(width: 0),
                      Expanded(
                        child: Card.outlined(
                          margin: EdgeInsets.all(6),
                          color: messages[index]['role'] == "user" ? Color.fromARGB(40, 0, 255, 0) : Colors.white,
                          child: ListTile(
                            title: Text("${messages[index]['content']}"),
                          ),
                        ),
                      ),
                      messages[index]["role"] == "assistant"
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
                  String question = userQuestion.text.trim();
                  if(question.isEmpty) return;

                  setState(() {
                    messages.add({"role": "user", "content": question});
                    userQuestion.clear();
                  });


                  // Uri uri = Uri.https("api.openai.com", "/v1/chat/completions");
                  // Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");
                  Uri uri = Uri.parse("http://192.168.100.97:11434/v1/chat/completions");


                  var headers = {
                    "Content-Type": "application/json",
                  };

                  var body = {
                    "model": "llama3.2",
                    // "model": "gpt-5.4-mini",
                    "messages": messages
                  };

                  http.post(uri, headers: headers, body: json.encode(body))
                  .then((resp) {

                    var aiResponse = json.decode(resp.body);
                    print(aiResponse);
                    String answer = aiResponse["choices"][0]["message"]["content"];

                    setState(() {
                      messages.add({"role": "assistant", "content": answer});
                      scrollController.jumpTo(
                          scrollController.position.maxScrollExtent + 800
                      );
                    });

                  }).catchError((err) {
                    print("****************************************");
                    print(err);
                    print("****************************************");
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
