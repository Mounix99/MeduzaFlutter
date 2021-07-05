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


  final _formKey = GlobalKey<FormState>();

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {

    final messages = Provider.of<List<MessageModel?>?>(context);
    TextEditingController? controller;

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
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() {
                          DataBaseServiceMessages().deleteMessage(messages[i]!.docId);
                        });
                        // Then show a snackbar.
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('message dismissed')));
                      },
                      background: Container(color: Colors.red),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 100,),
                          Flexible(
                            child: Card(
                              child: ElevatedButton(
                                onLongPress: () {},
                                onPressed: () {  },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(onPressed: () {}, child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL ?? "https://im0-tub-ua.yandex.net/i?id=7d228c3afb56ba2835217d16d5d62bd2&n=13"),),
                                        SizedBox(width: 5,),
                                        Text(messages[i]!.user, style: TextStyle(color: Colors.white),),
                                      ],
                                    )),
                                    Text(messages[i]!.text),
                                    Text(messages[i]!.time.toLocal().toString().substring(0,16), style: TextStyle(fontSize: 10),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() {
                          DataBaseServiceMessages().deleteMessage(messages[i]!.docId);
                        });
                        // Then show a snackbar.
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('message dismissed')));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(color: Colors.red),
                      child: Row(
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
                                    TextButton(onPressed: () {}, child: Row(
                                      children: [
                                        CircleAvatar(backgroundImage: NetworkImage("https://im0-tub-ua.yandex.net/i?id=7d228c3afb56ba2835217d16d5d62bd2&n=13"),),
                                        SizedBox(width: 5,),
                                        Text(messages[i]!.user, style: TextStyle(color: Colors.white),)
                                      ],
                                    )),
                                    Text(messages[i]!.text),
                                    Text(messages[i]!.time.toLocal().toString().substring(0,16), style: TextStyle(fontSize: 10),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 100,),
                        ],
                      ),
                    );
                  }
                } else {
                  return SizedBox(height: 0,);
                }
              }
            ),
          ),
          Form(
            key: widget._formKey,
            child:  TextFormField(
                    controller: controller,
                    decoration: textInputDecoration.copyWith(hintText: 'Enter your message',
                      suffixIcon: IconButton(
                        onPressed: () {
                          DataBaseServiceMessages().createMessageDocument(FirebaseAuth.instance.currentUser!.email!, widget.text, DateTime.now(), widget.dialogId, );
                          setState(() {
                            controller!.clear();
                          });
                          },
                        icon: Icon(Icons.send_sharp),
                      ),),
                    validator: (controller) => controller!.isEmpty ? "Enter your message" : null,
                    onChanged: (controller) {
                      setState(() {
                        widget.text = controller;

                      });
                    },
            ),
          ),
        ],
      )
    );
  }
}
