import 'package:flutter/material.dart';

class TentaclesList extends StatefulWidget {
  const TentaclesList({Key? key}) : super(key: key);

  @override
  _TentaclesListState createState() => _TentaclesListState();
}

class _TentaclesListState extends State<TentaclesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Tentacles"),
    );
  }
}
