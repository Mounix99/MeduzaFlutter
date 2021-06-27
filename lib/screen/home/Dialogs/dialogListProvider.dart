import 'package:meduza/models/dialogsModel.dart';
import 'package:meduza/screen/home/Chat/ChatPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DialogListProvider extends StatefulWidget {
  const DialogListProvider({Key? key}) : super(key: key);

  @override
  _DialogListProviderState createState() => _DialogListProviderState();
}

class _DialogListProviderState extends State<DialogListProvider> {
  @override
  Widget build(BuildContext dialogcontext) {

    final dialogs = Provider.of<List<MeduzaDialog?>?>(dialogcontext);

    return ListView.builder(
        itemCount: dialogs!.length ,
        itemBuilder: (dialogcontext, i) {
          if (dialogs.isEmpty) {
            return Text("Loading");
          } else {
            if (dialogs[i]!.users.containsValue(FirebaseAuth.instance.currentUser!.email))
            {
              if (dialogs[i]!.users["1"] == FirebaseAuth.instance.currentUser!.email){
                return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          dialogcontext,
                          MaterialPageRoute(
                            builder: (dialogcontext) => ChatPage(dialogId: dialogs[i]!.docId),
                          ));
                    },
                    child: Text(dialogs[i]!.users["2"])
                );

              } else {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          dialogcontext,
                          MaterialPageRoute(
                            builder: (dialogcontext) => ChatPage(dialogId: dialogs[i]!.docId),
                          ));
                    },
                    child: Text(dialogs[i]!.users["1"])
                );
              }
            } else {
              return SizedBox(height: 0,);
            }
          }
          //return Text(dialogs[i]!.users.toString());
        }
    );
  }
}