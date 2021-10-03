import 'dart:math';

import 'package:first_flutter_project/chattask/domain/entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late TextEditingController _controller;

  List<Message> dataSrc = [
    Message("Привет!", false),
  ];
  bool partnerIsTyping = false;

  void addMessage(String text, bool userAuthor) {
    Message msg = Message(text, userAuthor);
    dataSrc.add(msg);
  }

  void imitatePartnerMessage() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    String answer = partnerAnswers[Random().nextInt(partnerAnswers.length - 1)];
    partnerIsTyping = true;
    await Future.delayed(const Duration(seconds: 2), () {});
    partnerIsTyping = false;
    addMessage(answer, false);
  }

  void handleSend() {
    String text = _controller.text;
    addMessage(text, true);
    imitatePartnerMessage();
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Сообщения"),
        ),
        body: SafeArea(
            child: Center(
                child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Divider(),
              Expanded(
                  child: ListView(
                      reverse: true,
                      children: dataSrc.map((msg) {
                        return ListTile(title: Text(msg.text));
                      }).toList())),
              Divider(),
              if (partnerIsTyping) Text("Собеседник печатает..."),
              Row(children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: "Напишите что-нибудь"),
                ),
                if (_controller.text != "")
                  IconButton(onPressed: handleSend, icon: Icon(Icons.send)),
              ]),
            ],
          ),
        ))));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

List<String> partnerAnswers = [
  "Согласен",
  "Ты уверен в этом?",
  "Правда?",
  "...",
  "Хорошо",
  "Понял тебя",
  "Я тоже так считаю",
  "Так, вот сейчас не понял",
  "Хммм, тут нужно подумать",
  "Ну не, это не так",
  "Окей",
  "Ага",
  "Неа",
  "Опять ты начинаешь",
  "Ну допустим",
  "Я бы не был так уверен",
];
