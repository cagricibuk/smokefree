import 'package:flutter/material.dart';
import 'package:iknow/dailyModel.dart';
import 'package:iknow/helper/db_helperDaily.dart';

class Daily extends StatefulWidget {
  @override
  _DailyState createState() => _DailyState();
}

Future<List<DailyModel>> fetchBilgilerFromDatabase() async {
  var dbHelper = DBHelperDaily();

  Future<List<DailyModel>> bilgiler = dbHelper.getDailyBilgiler();

  return bilgiler;
}

class _DailyState extends State<Daily> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Günlükler",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: 520,
        child: FutureBuilder<List<DailyModel>>(
          future: fetchBilgilerFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
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
                        });

                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text("${snapshot.data[index].tarih} silindi")));
                      },
                      // child:

                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              new Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                            .data[index].tarih)
                                                        .day)
                                                    .toString(),
                                                style: TextStyle(fontSize: 26),
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
    );
  }
}
