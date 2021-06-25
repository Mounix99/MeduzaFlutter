import 'package:flutter/material.dart';
import 'package:meduza/screen/auth/authenticate.dart';
import 'package:meduza/screen/home/Home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    print(user);

    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
