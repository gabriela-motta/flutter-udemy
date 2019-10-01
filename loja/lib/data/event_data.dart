import 'package:cloud_firestore/cloud_firestore.dart';

class EventData {
  String id;
  String title;
  DateTime date;

  EventData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data["title"];
    date = DateTime.fromMillisecondsSinceEpoch(
        snapshot.data["date"].seconds * 1000);
  }
}
