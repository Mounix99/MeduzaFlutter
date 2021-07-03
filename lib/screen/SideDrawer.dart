import 'package:flutter/material.dart';
import 'package:meduza/screen/home/Home.dart';
import 'package:meduza/screen/settingsScreen/SettingsPage.dart';
import 'package:meduza/service/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL ?? "https://im0-tub-ua.yandex.net/i?id=7d228c3afb56ba2835217d16d5d62bd2&n=13"),),
                          SizedBox(width: 10,),
                          Text(FirebaseAuth.instance.currentUser!.displayName != null ? FirebaseAuth.instance.currentUser!.displayName! : FirebaseAuth.instance.currentUser!.email!,
                          style: TextStyle(fontSize: 25),)
                        ],
                      )
                    ],
                  )
                ],
              )
          ),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));
            }, child: Row(
            children: [
              Icon(Icons.home),
              Text("Home")
            ],
          )),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ));
            }, child: Row(
            children: [
              Icon(Icons.settings),
              Text("Profile settings")
            ],
          )),
          SizedBox(height: 15,),
          ElevatedButton(
              onPressed: () async{
                await AuthService().signOut();
              },
              child: Row(
                children: [
                  Icon(Icons.door_back),
                  Text("Logout")
                ],
              ))
        ],
      ),
    );
  }
}
