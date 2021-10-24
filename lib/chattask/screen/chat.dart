import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:first_flutter_project/chattask/domain/entities.dart';
import 'package:first_flutter_project/chattask/views/MessageBubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
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
    String answer = partnerAnswers[Random().nextInt(partnerAnswers.length - 1)];
    await Future.delayed(const Duration(seconds: 1), () {});
    setState(() {
      partnerIsTyping = true;
    });
    await Future.delayed(const Duration(seconds: 2), () {});
    setState(() {
      partnerIsTyping = false;
      addMessage(answer, false);
    });
  }

  void handleSend() {
    setState(() {
      String text = _controller.text;
      _controller.text = "";
      addMessage(text, true);
      imitatePartnerMessage();
    });
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
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: dataSrc.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(dataSrc[index]);
                    },
                  )),
                  if (partnerIsTyping)
                    Bubble(
                      child: Text("Собеседник печатает..."),
                    ),
                  Divider(),
                  Row(children: [
                    Expanded(
                        child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: "Сообщение..."),
                      onChanged: (text) {
                        setState(() {});
                      },
                    )),
                    if (_controller.text != "")
                      Wrap(children: [
                        IconButton(
                            onPressed: handleSend, icon: Icon(Icons.send))
                      ]),
                  ]),
                ],
              )),
        ));
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
