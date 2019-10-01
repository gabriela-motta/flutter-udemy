import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja/data/event_data.dart';

class EventTile extends StatelessWidget {
  final EventData event;

  EventTile(this.event);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 1,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                event.title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                DateFormat.Hm().format(event.date).toString(),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
