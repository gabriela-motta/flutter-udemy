import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/data/event_data.dart';
import 'package:loja/tiles/event_tile.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTab extends StatefulWidget {
  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  Map<DateTime, List> _events;
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events = {};
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
    });
  }

  Future<QuerySnapshot> _loadEvents() {
    return Firestore.instance
        .collection("events")
        .where("date",
            isGreaterThan: new DateTime(_selectedDay.year, _selectedDay.month,
                _selectedDay.day - 1, 23, 59, 59))
        .where("date",
            isLessThan: new DateTime(
                _selectedDay.year, _selectedDay.month, _selectedDay.day + 1))
        .getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            events: _events,
            locale: "pt_BR",
            calendarStyle: CalendarStyle(
              selectedColor: primaryColor,
              todayColor: Colors.red[600],
              weekdayStyle: TextStyle().copyWith(color: Colors.black),
              weekendStyle: TextStyle().copyWith(color: Colors.black),
              outsideDaysVisible: false,
              markersColor: Colors.brown[700],
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle().copyWith(color: Colors.black),
              weekendStyle: TextStyle().copyWith(color: Colors.black),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            onDaySelected: _onDaySelected,
          ),
          SizedBox(height: 8.0),
          Expanded(child: _buildEventList(context)),
        ],
      ),
    );
  }

  Widget _buildEventList(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _loadEvents(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var dividedTiles = ListTile.divideTiles(
                  context: context,
                  tiles: snapshot.data.documents.map((doc) {
                    return EventTile(EventData.fromDocument(doc));
                  }).toList(),
                  color: Colors.grey[500])
              .toList();
          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
