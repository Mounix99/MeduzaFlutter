import 'package:flutter/material.dart';
import 'package:meduza/screen/home/Dialogs/DialogsList.dart';
import 'package:meduza/screen/home/Planula/PlanulasList.dart';
import 'package:meduza/screen/home/Tentacles/TentaclesList.dart';
import 'package:meduza/service/authService.dart';
import 'package:meduza/screen/SideDrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedIndex = 0;
  Widget  _planulsList = PlanulasList();
  Widget _tentaclesList = TentaclesList();
  Widget _dialogList = DialogsList();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title:  Text("MEDUZA PLANULA"),
      ),
      drawer: SideDrawer(),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: "Planulas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi_protected_setup_outlined),
            label: "Tentacles",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Dialogs",
          )
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody( )  {
    if(this.selectedIndex == 0) {
      return this._planulsList;
    } else
    if(this.selectedIndex==1) {
      return this._tentaclesList;
    } else {
      return this._dialogList;
    }
  }

  void onTapHandler(int index)  {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

}

