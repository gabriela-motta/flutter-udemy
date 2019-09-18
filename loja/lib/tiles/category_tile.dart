import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 8),
      leading: CircleAvatar(
        child: ClipOval(
          child: Image.network(
            snapshot.data["icon"],
            fit: BoxFit.cover,
          ),
        ),
        radius: 30,
        backgroundColor: Colors.transparent,
      ),
      title: Text(
        snapshot.data["title"],
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CategoryScreen(snapshot)));
      },
    );
  }
}
