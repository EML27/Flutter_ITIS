import 'package:bubble/bubble.dart';
import 'package:first_flutter_project/chattask/domain/entities.dart';
import 'package:first_flutter_project/chattask/views/MessageBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:first_flutter_project/mobx/chat_data.dart';

final messageStorage = MessageStateManager();
final currentUserName = "EML";

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late TextEditingController _controller;

  bool partnerIsTyping = false;

  void handleSend() {
    setState(() {
      String text = _controller.text;
      _controller.text = "";
      messageStorage.sendMessage(Message(currentUserName, text));
    });
  }

  @override
  void initState() {
    _controller = TextEditingController();
    messageStorage.loadData();
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
                  MessagesWidget(),
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

class MessagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Expanded(
                child: ListView.builder(
              itemCount: messageStorage.data.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                    messageStorage.data.reversed.toList()[index], currentUserName);
              },
              reverse: true,
            )));
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
