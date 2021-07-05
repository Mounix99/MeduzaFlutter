import 'package:meduza/models/dialogsModel.dart';
import 'package:meduza/screen/home/Chat/ChatPage.dart';
import 'package:meduza/service/dataBaseService.dart';
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
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      DataBaseServiceDialogs().deleteDialog(dialogs[i]!.docId);
                    });
                    // Then show a snackbar.
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('dialog has been deleted')));
                  },
                  background: Container(color: Colors.red),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              dialogcontext,
                              MaterialPageRoute(
                                builder: (dialogcontext) => ChatPage(dialogId: dialogs[i]!.docId),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage("https://im0-tub-ua.yandex.net/i?id=7d228c3afb56ba2835217d16d5d62bd2&n=13"),),
                              SizedBox(width: 5,),
                              Text(dialogs[i]!.users["2"]),
                            ],
                          ),
                        )
                    ),
                  ),
                );

              } else {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      DataBaseServiceDialogs().deleteDialog(dialogs[i]!.docId);
                    });
                    // Then show a snackbar.
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('dialog has been deleted')));
                  },
                  background: Container(color: Colors.red),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              dialogcontext,
                              MaterialPageRoute(
                                builder: (dialogcontext) => ChatPage(dialogId: dialogs[i]!.docId),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL ?? "https://im0-tub-ua.yandex.net/i?id=7d228c3afb56ba2835217d16d5d62bd2&n=13"),),
                              SizedBox(width: 5,),
                              Text(dialogs[i]!.users["1"]),
                            ],
                          ),
                        )
                    ),
                  ),
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