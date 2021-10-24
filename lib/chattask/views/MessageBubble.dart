import 'package:bubble/bubble.dart';
import 'package:first_flutter_project/chattask/domain/entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  Message msg;

  MessageBubble(this.msg);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      child: Text(
        msg.text,
        textAlign: msg.isAuthorUser ? TextAlign.right : TextAlign.left,
      ),
      color: msg.isAuthorUser ? Colors.lightBlueAccent : Colors.lightGreenAccent,
      alignment: msg.isAuthorUser ? Alignment.topRight : Alignment.topLeft,
      margin: BubbleEdges.all(8),
    );
  }
}
