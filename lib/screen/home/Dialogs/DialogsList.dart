import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meduza/service/dataBaseService.dart';
import 'package:meduza/shared/constants.dart';

import 'dialogListProvider.dart';

class DialogsList extends StatefulWidget {
  const DialogsList({Key? key}) : super(key: key);

  @override
  _DialogsListState createState() => _DialogsListState();
}

class _DialogsListState extends State<DialogsList> {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = '';
    String error = '';

    return Scaffold(
        body: DialogListProvider(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  elevation: 16,
                  child: Container(
                    height: 400.0,
                    width: 360.0,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Enter user email",
                            style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        Form(
                            key: _formKey,
                            child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  TextFormField(
                                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                                    validator: (val) => val!.isEmpty ? "Enter email person you want to write to" : null,
                                    onChanged: (val) {
                                      setState(() {
                                        userEmail = val;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()){
                                          dynamic result = await DataBaseServiceDialogs().createDialog({"1":user!.email, "2":userEmail});
                                          if(result == null) {
                                            setState(() {
                                              error = "please ";
                                            });
                                          }
                                        }
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: Text(
                                        "Create dialog",
                                      )),]))
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.pending_actions_sharp),
        )
    );
  }
}
