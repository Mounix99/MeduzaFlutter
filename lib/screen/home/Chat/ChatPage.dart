import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage ({required this.dialogId});

  final String dialogId;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.dialogId),
    );
  }
}
