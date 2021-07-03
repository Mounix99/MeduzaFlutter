import 'package:flutter/material.dart';
import 'package:meduza/models/planulaModel.dart';
import 'package:provider/provider.dart';
import 'package:link_previewer_aad/link_previewer_aad.dart';

class TentaclesList extends StatefulWidget {
  const TentaclesList({Key? key}) : super(key: key);

  @override
  _TentaclesListState createState() => _TentaclesListState();
}

class _TentaclesListState extends State<TentaclesList> {
  @override
  Widget build(BuildContext context) {

    final planulas = Provider.of<List<Planula?>?>(context);

    return Container(
      child: Scaffold(
        body: ListView.builder(
              itemCount: planulas?.length ,
              itemBuilder: (context, i) {
                if (planulas![i]!.access)
                {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextButton(
                      onPressed: () async{
                        // await launch(
                        //     planulas[i]!.url,
                        //     forceSafariVC: true,
                        //     forceWebView: true,
                        //     enableJavaScript: true,
                        // );
                      },
                      child: LinkPreviewerAad(
                        link: planulas[i]!.url,
                        direction: ContentDirection.horizontal,
                        borderColor: Colors.blue,
                        borderRadius: 30,
                        showBody: true,
                        bodyTextOverflow: TextOverflow.fade,
                        defaultPlaceholderColor: Colors.blue,
                      ),
                    ),
                  );
                } else {
                  return SizedBox(height: 0,);
                }
              }
          )
      ),
    );
  }
}
