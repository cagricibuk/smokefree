import 'package:flutter/material.dart';
import 'package:iknow/dailyModel.dart';
import 'package:iknow/event.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:iknow/helper/db_helperDaily.dart';

class DayPickerPage extends StatefulWidget {
  final List<Event> events;

  const DayPickerPage({Key key, this.events}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DayPickerPageState();
}

class _DayPickerPageState extends State<DayPickerPage> {
  var dbHelper = DBHelperDaily();
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
  List etkinlikler;
  List notes;
  List icildiBilgileri;

  void eventDetailsSetup() async {
    var dbHelper = DBHelperDaily();
    print('=== getBİlgiler() ===');
    notes = await dbHelper.getOnlyDates();

    notes.forEach((note) => etkinlikler.add(note.tarih));

    notes.forEach((note) => icildiBilgileri.add(note.ictimi));
    setState(() {
      for (var i = 0; i < notes.length; i++) {
        widget.events
            .add(Event(etkinlikler[i], "aciklama", icildiBilgileri[i]));
      }
    });
  }

  DateTime _selectedDate;
  DateTime _firstDate;
  DateTime _lastDate;
  Color selectedDateStyleColor = Colors.blue;
  Color selectedSingleDateDecorationColor;

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
        currentDateStyle: TextStyle(color: Colors.yellow),
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
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: FutureBuilder<List<DailyModel>>(
            future: fetchBilgilerFromDatabase(),
            builder: (context, snapshot) {
              print(widget.events);
              if (snapshot.hasData) {
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      widget.events.add(Event(
                          DateTime.parse(snapshot.data[index].tarih),
                          "aciklama",
                          snapshot.data[index].ictimi));

                      return Dismissible(
                        background: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        key: Key(snapshot.data[index].id.toString()),
                        onDismissed: (direction) {
                          setState(() {
                            // snapshot.data.removeAt(index);

                            dbHelper.deleteDaily(snapshot.data[index].id);
                            (widget.events).removeAt(index);
                            (context as Element).reassemble();
                          });

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "${snapshot.data[index].tarih} silindi")));
                        },
                        // child:

                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Card(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 20,
                                              color: Colors.lightGreen,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        4, 2, 0, 0),
                                                child: Text(
                                                  "${aylar[DateTime.parse(snapshot.data[index].tarih).month - 1]} ${DateTime.parse(snapshot.data[index].tarih).year}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 60,
                                              height: 45,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 8, 0, 0),
                                                child: Text(
                                                  (DateTime.parse(snapshot
                                                              .data[index]
                                                              .tarih)
                                                          .day)
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 26),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          new Text(
                                              "Sigara içildi:${snapshot.data[index].ictimi.toString()}",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          new Text(
                                              "Cravings:${snapshot.data[index].cravings.toString()}",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          new Text(
                                              "Sigara Şiddet:${snapshot.data[index].zorlanma}",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0)),
                                        ],
                                      ),
                                    ]),
                                Column(
                                  children: [
                                    Text(
                                        "${snapshot.data[index].zorlanma}"
                                            .toString(),
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.data.length == 0) {
                return new Text("No Data found");
              } else
                return Container(
                  child: Text("Henüz gönderi yok"),
                );
            },
          ),
        ),
      ],
    );
  }

  // selected daily informations

  void _onSelectedDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
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
