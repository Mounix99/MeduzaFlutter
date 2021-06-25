import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meduza/models/planulaModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meduza/models/planulaModel.dart';

class DataBaseService {

  final CollectionReference planulaReferense = FirebaseFirestore.instance.collection('Planulas');

  //add Planula element to collection
  Future addPlanula(String url, String email, String description, DateTime dateTime, bool access) async {
    return await planulaReferense.doc(FirebaseAuth.instance.currentUser!.email).collection('planulas').add({
      'url': url,
      'email': email,
      'description': description,
      'datetime': dateTime,
      'access' : access
    });
  }

  //get list of planulas from db
  List<Planula?> _listPlanulas(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
        return Planula(
          url: doc.get('url'),
          email: doc.get('email'),
          description: doc.get('description'),
          dateTime: doc.get('datetime').toDate(),
          access: doc.get('access'),
        );
    }).toList();
  }

  Stream<List<Planula?>> get planulas {
    return planulaReferense.doc(FirebaseAuth.instance.currentUser!.email).collection('planulas').snapshots().
    map(_listPlanulas);
  }
}