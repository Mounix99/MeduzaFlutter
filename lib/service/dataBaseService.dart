import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meduza/models/dialogsModel.dart';
import 'package:meduza/models/messageModel.dart';
import 'package:meduza/models/planulaModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meduza/models/planulaModel.dart';

class DataBaseServicePlanula {

  final CollectionReference planulaReferense = FirebaseFirestore.instance.collection('Planulas');

  //add Planula element to collection
  Future addPlanula(String url, String userId, String description, DateTime dateTime, bool access) async {
    return await planulaReferense.add({
      'url': url,
      'userId': userId,
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
          userId: doc.get('userId'),
          description: doc.get('description'),
          dateTime: doc.get('datetime').toDate(),
          access: doc.get('access'),
        );
    }).toList();
  }

  //stream for Multiprovider planulalist
  Stream<List<Planula?>> get planulas {
    return planulaReferense.snapshots().
    map(_listPlanulas);
  }
}

class DataBaseServiceDialogs {

  final CollectionReference dialogReference = FirebaseFirestore.instance.collection('Dialogs');

  //add dialog to a collection
  Future createDialog(Map<String,String?> users) async{
    return await dialogReference.add({
      'users': users
    });
  }

  //get List from db
  List<MeduzaDialog?> _listDialog(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MeduzaDialog(
          users: doc.get('users'),
          docId: doc.id
      );
    }).toList();
  }

  //Stream for Multiprovider dialogs
  Stream<List<MeduzaDialog?>?> get dialogs {
    return dialogReference.snapshots().
    map(_listDialog);
  }

}

class DataBaseServiceMessages {
  DataBaseServiceMessages({required this.dialogId});

  late String dialogId;

  final CollectionReference messagesReference = FirebaseFirestore.instance.collection('Dialogs');

  //add message
  Future createMessageDocument(String user, String text, DateTime time) async{
    return await messagesReference.doc(dialogId).collection('Messages').add({
      'user': user,
      'text' : text,
      'time' : time
    });
  }

  //get List of messages
  List<MessageModel?> _listMessages(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MessageModel(
          user: doc.get('user'),
          text: doc.get('text'),
          time: doc.get('time'),
      );
    }).toList();
  }

  Stream<List<MeduzaDialog?>?> get messages {
    return messagesReference.doc(dialogId).collection('Messages').snapshots().
    map(_listMessages);
  }

}