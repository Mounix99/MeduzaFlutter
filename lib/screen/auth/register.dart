import 'package:flutter/material.dart';
import 'package:meduza/service/authService.dart';
import 'package:meduza/shared/constants.dart';

class Register extends StatefulWidget {
  Register({required this.toggleView});

  final Function toggleView;


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up your Meduza account"),
        actions: [
          ElevatedButton(
              onPressed: () {
                widget.toggleView();
              },
              child: Row(
                children: [
                  Icon(Icons.person),
                  Text("Sign In")
                ],
              ))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val!.isEmpty ? "Enter an email" : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val!.length < 6 ? "Enter a password more then 6 chars" : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()){
                        dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                        if(result == null) {
                          setState(() {
                            error = "please chek your email and password";
                          });
                        }
                      }
                    },
                    child: Text(
                      "Register",
                    )),
                SizedBox(height: 12,),
                Text(error, style: TextStyle(color:  Colors.red),)
              ],
            ),
          )
      ),
    );;
  }
}
