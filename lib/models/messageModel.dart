class MessageModel {
  late String user;
  late String text;
  late DateTime time;
  late String dialogId;
  late String docId;

  MessageModel({required this.user, required this.text, required this.time, required this.dialogId, required this.docId});
}