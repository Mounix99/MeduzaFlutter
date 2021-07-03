import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meduza/screen/SideDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meduza/service/authService.dart';
import 'package:meduza/shared/constants.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  String url = '';
  String nickName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.settings),
            SizedBox(width: 10,),
            Text("Settings"),
          ],
        ),
      ),
      drawer: SideDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL ?? "https://im0-tub-ua.yandex.net/i?id=7d228c3afb56ba2835217d16d5d62bd2&n=13"),
                    radius: 60,),
                    SizedBox(width: 10,),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                  elevation: 16,
                                  child:  Container(
                                    height: 250,
                                    width: 400,
                                    child: ListView(
                                      children: <Widget>[
                                        SizedBox(height: 20),
                                        Center(
                                          child: Text(
                                            "Past url of your Photo",
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
                                                    decoration: textInputDecoration.copyWith(hintText: 'URL'),
                                                    validator: (val) => val!.isEmpty ? "Enter uor Url" : null,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        url = val;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(height: 20),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        if (_formKey.currentState!.validate()){
                                                          dynamic result = await AuthService().userPhotoUpdate(url);
                                                          if(result == null) {
                                                            setState(() {
                                                              var error = "please chek your URL";
                                                            });
                                                          }
                                                        }
                                                        Navigator.pop(context, 'OK');
                                                      },
                                                      child: Text("Update your profile photo"))
                                                ]))
                                      ],
                                    ),
                                  ),
                                );
                          });
                        },
                        child: Text("Update user photo"))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Your Nickname:"),
                  Text(FirebaseAuth.instance.currentUser!.displayName != null?  FirebaseAuth.instance.currentUser!.displayName! : "no name"),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child:  Container(
                                  height: 250,
                                  width: 400,
                                  child: ListView(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Center(
                                        child: Text(
                                          "Past your Nickname",
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
                                                  decoration: textInputDecoration.copyWith(hintText: 'Nickname'),
                                                  validator: (val) => val!.isEmpty ? "Enter your Nickname" : null,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      nickName = val;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 20),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      if (_formKey.currentState!.validate()){
                                                        dynamic result = await AuthService().userDisplayNameUpdate(nickName);
                                                        if(result == null) {
                                                          setState(() {
                                                            var error = "please chek your nickname";
                                                          });
                                                        }
                                                      }
                                                      Navigator.pop(context, 'OK');
                                                    },
                                                    child: Text("Update your Nickname"))
                                              ]))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text("Update Nickname"))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Push to delete your account"),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child:  Container(
                                  height: 200,
                                  width: 400,
                                  child: ListView(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Do you really want to delete your account without ability to cancel it?",
                                            style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Form(
                                          key: _formKey,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      if (_formKey.currentState!.validate()){
                                                        dynamic result = await AuthService().userDisplayNameUpdate(nickName);
                                                        if(result == null) {
                                                          setState(() {
                                                            var error = "please chek your nickname";
                                                          });
                                                        }
                                                      }
                                                      Navigator.pop(context, 'OK');
                                                    },
                                                    child: Text("Delete")),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context, 'OK');
                                                    },
                                                    child: Text("Cancel"))
                                              ]))
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                      child: Text("Delete"),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
