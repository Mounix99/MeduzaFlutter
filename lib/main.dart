import 'package:flutter/material.dart';
import 'package:meduza/models/planulaModel.dart';
import 'package:meduza/screen/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meduza/service/authService.dart';
import 'package:meduza/service/dataBaseService.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/dialogsModel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      StreamProvider<User?>(
      initialData: null,
        create: (context) => AuthService().user,),
      StreamProvider<List<Planula?>?>(initialData: null,
        create: (context) => DataBaseServicePlanula().planulas,
      ),
      StreamProvider<List<MeduzaDialog?>?>(initialData: null,
        create: (context) => DataBaseServiceDialogs().dialogs,
      )
    ],
    child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.a
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Wrapper()
    );
  }
}
