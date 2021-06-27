import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meduza/models/messageModel.dart';
import 'package:meduza/service/dataBaseService.dart';
import 'package:meduza/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  ChatPage ({required this.dialogId});

  final String dialogId;

  late String text;
  late String error;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {

    final messages = Provider.of<List<MessageModel?>?>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: messages!.length,
              itemBuilder: (context, i) {
                if (messages[i]!.dialogId == widget.dialogId) {
                  if (messages[i]!.user == FirebaseAuth.instance.currentUser!.email) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 1,),
                        Flexible(
                          child: Card(
                            child: ElevatedButton(
                              onLongPress: () {},
                              onPressed: () {  },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL ?? ""),),
                                  TextButton(onPressed: () {}, child: Text(messages[i]!.user, style: TextStyle(color: Colors.white),)),
                                  Text(messages[i]!.text),
                                  Text(messages[i]!.time.toLocal().toString().substring(0,16), style: TextStyle(fontSize: 10),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Card(
                            child: ElevatedButton(
                              onLongPress: () {},
                              onPressed: () {  },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(onPressed: () {}, child: Text(messages[i]!.user, style: TextStyle(color: Colors.white),)),
                                  Text(messages[i]!.text),
                                  Text(messages[i]!.time.toLocal().toString().substring(0,16), style: TextStyle(fontSize: 10),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 1,),
                      ],
                    );
                  }
                } else {
                  return SizedBox(height: 0,);
                }
              }
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 8,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Enter your message'),
                  validator: (val) => val!.isEmpty ? "Enter your message" : null,
                  onChanged: (val) {
                    setState(() {
                      widget.text = val;
                    });
                  },
                ),
              ),
              Flexible(
                flex: 2,
                child: ElevatedButton(
                    onPressed: () async {
                      dynamic result = await DataBaseServiceMessages().createMessageDocument(FirebaseAuth.instance.currentUser!.email!, widget.text, DateTime.now(), widget.dialogId);
                    },
                    child: Icon( Icons.send_sharp)),
              )
            ],
          )
        ],
      ),
    );
  }
}
