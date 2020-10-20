import 'package:flutter/material.dart';
import 'package:iknow/ana.dart';
import 'package:iknow/dailyModel.dart';
import 'package:iknow/event.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:iknow/helper/db_helperDaily.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iknow/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DayPickerPage extends StatefulWidget {
  final List<Event> events;

  const DayPickerPage({Key key, this.events}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DayPickerPageState();
}

class _DayPickerPageState extends State<DayPickerPage> {
  var dbHelper = DBHelperDaily();
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List aylar = [
    "Oca",
    "Şub",
    "Mar",
    "Nis",
    "May",
    "Haz",
    "Tem",
    "Agu",
    "Eyl",
    "Eki",
    "Ara"
  ];
  List<DateTime> etkinlikler = [];
  List notes;
  List icildiBilgileri = [];
  List idler = [];

  void eventDetailsSetup() async {
    var dbHelper = DBHelperDaily();
    print('=== getBİlgiler() ===');
    notes = await dbHelper.getOnlyDates();
    final User user = auth.currentUser;
    final uid = user.uid;
    print(uid);
    notes.forEach((note) => firestore
        .collection('users')
        .doc(uid)
        .collection("daily")
        .doc(note.id.toString())
        .set({
          "icildiBilgileri": note.ictimi,
          "tane": note.kactane,
          "tarih": note.tarih,
          "zorlanma": note.zorlanma,
          "cravings": note.cravings,
        })
        .then((value) => print("daily uploaded"))
        .catchError((error) => print("Failed to upload: $error")));

    notes.forEach((note) => etkinlikler.add(DateTime.parse(note.tarih)));
    notes.forEach((note) => idler.add(note.id));
    notes.forEach((note) => icildiBilgileri.add(note.ictimi));
    notes.forEach((note) => tane.add(note.kactane));
    notes.forEach((note) => zorlanma.add(note.zorlanma));
    notes.forEach((note) => cravings.add(note.cravings));

    setState(() {
      for (var i = 0; i < notes.length; i++) {
        widget.events
            .add(Event(etkinlikler[i], "aciklama", icildiBilgileri[i]));
      }
    });
  }

  List tane = [];
  List zorlanma = [];
  List cravings = [];
  var indis;
  DateTime _selectedDate;
  DateTime _firstDate;
  DateTime _lastDate;
  Color selectedDateStyleColor = Colors.blue;
  Color selectedSingleDateDecorationColor;
  int takvimWidth = 72;
  var _currentDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 2);

  var _ictimi;
  var _gosterAltbar = false;
  var _id;
  var _kactane;
  var _zorlanma;
  var _cravings;

  @override
  void initState() {
    super.initState();
    eventDetailsSetup();

    _selectedDate = DateTime.now();
    _firstDate = DateTime.now().subtract(Duration(days: 45));
    _lastDate = DateTime.now().add(Duration(days: 45));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    selectedDateStyleColor = Colors.white;
    selectedSingleDateDecorationColor = Colors.lightBlue;
  }

  Future<List<DailyModel>> fetchBilgilerFromDatabase() async {
    var dbHelper = DBHelperDaily();

    Future<List<DailyModel>> bilgiler = dbHelper.getDailyBilgiler();

    return bilgiler;
  }

  @override
  Widget build(BuildContext context) {
    // add selected colors to default settings
    dp.DatePickerStyles styles = dp.DatePickerRangeStyles(
        currentDateStyle: TextStyle(color: Colors.blue),
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            .copyWith(color: selectedDateStyleColor),
        selectedSingleDateDecoration: BoxDecoration(
            color: selectedSingleDateDecorationColor,
            shape: BoxShape.rectangle));

    return Flex(
      direction: MediaQuery.of(context).orientation == Orientation.portrait
          ? Axis.vertical
          : Axis.horizontal,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.2,
          child: dp.DayPicker(
            selectedDate: _selectedDate,
            onChanged: _onSelectedDateChanged,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
            datePickerLayoutSettings: dp.DatePickerLayoutSettings(
                maxDayPickerRowCount: 2,
                showPrevMonthEnd: true,
                showNextMonthStart: true),
            selectableDayPredicate: _isSelectableCustom,
            eventDecorationBuilder: _eventDecorationBuilder,
          ),
        ),
        Visibility(
          visible: _gosterAltbar,
          child: Card(
            elevation: 2,
            child: Container(
              color: Colors.grey[100],
              height: MediaQuery.of(context).size.height / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            Container(
                              width: 90,
                              height: 30,
                              color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 2, 0, 0),
                                child: Text(
                                  "${aylar[_currentDate.month - 1]} ${_currentDate.year}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              width: takvimWidth.toDouble(),
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                                child: Text(
                                  "${_currentDate.day}",
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (_kactane != null)
                        Text("İçilen Sigara Sayisi: $_kactane"),
                      if (_cravings != null)
                        Text("Cravings ${_cravings.toString()}"),
                      if (_zorlanma != null)
                        Text("Zorlanma Derecesi ${_zorlanma.toString()}"),
                      //if (_currentDate != null) Text(_currentDate.toString()),
                      if (_ictimi != null) Text(_ictimi),
                      SizedBox(
                        width: 10,
                      ),
                      if (_id != null) Text("id ${_id.toString()}"),
                    ],
                  ),
                  FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        dbHelper.deleteDaily(idler[indis]);
                        widget.events.clear();
                        //eventDetailsSetup();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnaSayfa(
                              indis: 1,
                            ),
                          ),
                        );
                      });
                    },
                    child: Text(
                      "Günlüğü Sil",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // selected daily informations

  void _onSelectedDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      if (etkinlikler.contains(_selectedDate)) {
        indis = etkinlikler.indexOf(_selectedDate);
        print(indis);
        _currentDate = etkinlikler[indis];
        if (etkinlikler[indis].day.toInt() < 10)
          takvimWidth = 50;
        else
          takvimWidth = 80;
        _ictimi = icildiBilgileri[indis];
        _id = idler[indis];
        _kactane = tane[indis];
        _zorlanma = zorlanma[indis];
        _cravings = cravings[indis];

        _gosterAltbar = true;
      } else {
        _gosterAltbar = false;
      }
    });
  }

  bool _isSelectableCustom(DateTime day) {
    return day.weekday < 8;
  }

  List kirmizilarListDondur() {
    List<DateTime> kirmizilar = [];

    widget.events.forEach((element) {
      if (element.ictimi == "true") {
        kirmizilar.add(element.date);
      }
    });
    return kirmizilar;
  }

  List yesillerListDondur() {
    List<DateTime> yesiller = [];

    widget.events.forEach((element) {
      if (element.ictimi == "false") {
        yesiller.add(element.date);
      }
    });
    return yesiller;
  }

  // ignore: missing_return
  dp.EventDecoration _eventDecorationBuilder(DateTime date) {
    //widget.events?.map<DateTime>((Event e) => e.date)?.toList();
    List<DateTime> kirmiziTarihler = kirmizilarListDondur();
    List<DateTime> eventsDates = yesillerListDondur();
    bool isEventDate = eventsDates?.any((DateTime d) =>
            date.year == d.year &&
            date.month == d.month &&
            d.day == date.day) ??
        false;

    bool kirmizimi = kirmiziTarihler?.any((DateTime d) =>
            date.year == d.year &&
            date.month == d.month &&
            d.day == date.day) ??
        false;
    BoxDecoration roundedBorder = BoxDecoration(
        color: Colors.green,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(3.0)));

    BoxDecoration roundedBorder2 = BoxDecoration(
        color: Colors.red[400],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(3.0)));

    if (isEventDate)
      return dp.EventDecoration(boxDecoration: roundedBorder);
    else if (kirmizimi)
      return dp.EventDecoration(boxDecoration: roundedBorder2);
  }
}
