import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meduza/models/planulaModel.dart';
import 'package:meduza/shared/constants.dart';
import 'package:meduza/service/dataBaseService.dart';
import 'package:provider/provider.dart';
import 'planulaListProvider.dart';

class PlanulasList extends StatefulWidget {
  const PlanulasList({Key? key}) : super(key: key);

  @override
  _PlanulasListState createState() => _PlanulasListState();
}

class _PlanulasListState extends State<PlanulasList> {

  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  String description = '';
  String url = '';
  bool _value = false;
  String error = '';


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: PlanulaListProvider(),
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
                          "Past url",
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
                            TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: 'Description'),
                              validator: (val) => val!.isEmpty? "Enter Description" : null,
                              onChanged: (val) {
                                setState(() {
                                  description = val;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()){
                                          dynamic result = await DataBaseServicePlanula().addPlanula(url, user!.uid, description, DateTime.now(), _value);
                                          if(result == null) {
                                            setState(() {
                                              error = "please chek your URL";
                                            });
                                          }
                                        }
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: Text(
                                        "Add as private",
                                      )),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()){
                                          dynamic result = await DataBaseServicePlanula().addPlanula(url, user!.uid, description, DateTime.now(), _value);
                                          if(result == null) {
                                            setState(() {
                                              error = "please chek your URL";
                                            });
                                          }
                                        }
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: Text(
                                        "Add as public",
                                      )),
                                ],
                              )
                              ]))
                    ],
                  ),
                ),
              );
          },
        );
       },
          child: Icon(Icons.plus_one),
      )
    );
  }
}

