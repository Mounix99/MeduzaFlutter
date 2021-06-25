import 'package:flutter/material.dart';
import 'package:meduza/service/authService.dart';


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
                  Text("Profile")
                ],
              )
          ),
          ElevatedButton(
              onPressed: () async{
                await AuthService().signOut();
              },
              child: Row(
                children: [
                  Icon(Icons.person),
                  Text("Logout")
                ],
              ))
        ],
      ),
    );
  }
}
