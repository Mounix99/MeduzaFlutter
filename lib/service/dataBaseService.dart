import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meduza/models/dialogsModel.dart';
import 'package:meduza/models/messageModel.dart';
import 'package:meduza/models/planulaModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meduza/models/planulaModel.dart';

class DataBaseServicePlanula {

  final CollectionReference planulaReference = FirebaseFirestore.instance.collection('Planulas');

  //add Planula element to collection
  Future addPlanula(String url, String userId, String description, DateTime dateTime, bool access) async {
    return await planulaReference.add({
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
          docId: doc.id
        );
    }).toList();
  }

  //stream for Multiprovider planulalist
  Stream<List<Planula?>> get planulas {
    return planulaReference.orderBy('datetime', descending: true).snapshots().
    map(_listPlanulas);
  }

  Future deletePlanula(String docId) async {
    planulaReference.doc(docId).delete();
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

  Future deleteDialog(String docId) async {
    dialogReference.doc(docId).delete();
  }

}

class DataBaseServiceMessages {

  final CollectionReference messagesReference = FirebaseFirestore.instance.collection('Messages');

  //add message
  Future createMessageDocument(String user, String text, DateTime time, String dialogId) async{
    return await messagesReference.add({
      'user': user,
      'text' : text,
      'time' : time,
      'dialogId' : dialogId
    });
  }

  //get List of messages
  List<MessageModel?> _listMessages(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MessageModel(
          user: doc.get('user'),
          text: doc.get('text'),
          time: doc.get('time').toDate(),
          dialogId: doc.get('dialogId'),
          docId: doc.id
      );
    }).toList();
  }

  Stream<List<MessageModel?>> get messages {
    return messagesReference.orderBy('time', descending: true).snapshots().
    map(_listMessages);
  }

  Future deleteMessage(String docId) async {
    messagesReference.doc(docId).delete();
  }

}