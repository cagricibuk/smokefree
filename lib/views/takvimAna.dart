import 'package:flutter/material.dart';
import 'package:iknow/dailyModel.dart';
import 'package:iknow/event.dart';
import 'package:iknow/helper/db_helperDaily.dart';

import 'takvim.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Future<List<DailyModel>> fetchDatesFromDatabase() async {
    var dbHelper = DBHelperDaily();

    Future<List<DailyModel>> bilgiler = dbHelper.getOnlyDates();

    return bilgiler;
  }

  DateTime startOfPeriod;
  DateTime endOfPeriod;
  DateTime firstDate;
  DateTime lastDate;

  int _selectedTab;

  final List<Widget> datePickers = <Widget>[
    DayPickerPage(
      events: events,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // eventDetailsSetup();

    _selectedTab = 0;
    DateTime now = DateTime.now();

    firstDate = now.subtract(Duration(days: 10));
    lastDate = now.add(Duration(minutes: 10));

    startOfPeriod = firstDate;
    endOfPeriod = lastDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Günlük",
          style: TextStyle(letterSpacing: 1.15, color: Colors.white),
        ),
      ),
      body: Card(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: datePickers[_selectedTab]),
      ),
    );
  }
}

List<Event> events = [];
