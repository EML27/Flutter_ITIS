import 'package:bubble/bubble.dart';
import 'package:first_flutter_project/chattask/domain/entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message msg;
  final String curUser;

  MessageBubble(this.msg, this.curUser);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      child: Column(children: [
        Text(msg.author),
        Text(
          msg.message,
          textAlign: msg.author == curUser ? TextAlign.right : TextAlign.left,
        )
      ]),
      color: msg.author == curUser
          ? Colors.lightBlueAccent
          : Colors.lightGreenAccent,
      alignment: msg.author == curUser ? Alignment.topRight : Alignment.topLeft,
      margin: BubbleEdges.all(8),
    );
  }
}
