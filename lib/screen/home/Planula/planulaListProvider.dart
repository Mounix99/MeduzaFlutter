import 'package:meduza/models/planulaModel.dart';
import 'package:meduza/service/authService.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:link_previewer_aad/link_previewer_aad.dart';
import 'package:firebase_auth/firebase_auth.dart';


class PlanulaListProvider extends StatefulWidget {
  const PlanulaListProvider({Key? key}) : super(key: key);

  @override
  _PlanulaListProviderState createState() => _PlanulaListProviderState();
}

class _PlanulaListProviderState extends State<PlanulaListProvider> {
  @override
  Widget build(BuildContext context) {

    final planulas = Provider.of<List<Planula?>?>(context);

    return ListView.builder(
      itemCount: planulas!.length,
        itemBuilder: (context, int) {
          return LinkPreviewerAad(
            link: planulas[int]!.url,
            direction: ContentDirection.horizontal,
          );
        }
    );

    return Container();
  }
}
