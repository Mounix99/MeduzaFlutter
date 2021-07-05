import 'package:meduza/models/planulaModel.dart';
import 'package:meduza/service/dataBaseService.dart';
import 'package:url_launcher/url_launcher.dart';
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

        itemCount: planulas?.length ,
        itemBuilder: (context, i) {
            if (planulas![i]!.userId.toString() == FirebaseAuth.instance.currentUser!.uid)
            {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  setState(() {
                    DataBaseServicePlanula().deletePlanula(planulas[i]!.docId);
                    print(planulas[i]!.docId.toString());
                  });
                  // Then show a snackbar.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Planula has been deleted')));
                },
                background: Container(color: Colors.red),
                child: Padding(
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
                ),
              );
            } else {
              return SizedBox(height: 0,);
            }
        }
    );
  }
}
