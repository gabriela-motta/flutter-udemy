import 'package:flutter/material.dart';
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
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                event.title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                "${event.date.hour.toString()}:${event.date.minute.toString()}",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
