import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      title: Text(
        snapshot.data["title"],
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {},
    );
  }
}
