import 'package:flutter/material.dart';
import 'package:iknow/helper/db_helperTips.dart';
import 'package:iknow/tipsModel.dart';

class Tips extends StatefulWidget {
  final int puan;
  Tips({this.puan});
  @override
  _TipsState createState() => _TipsState();
}

_icon(a) {
  if (a == "false")
    return Icon(
      Icons.favorite_border_outlined,
      color: Colors.green,
      size: 30,
    );
  else
    return Icon(
      Icons.favorite,
      color: Colors.green,
      size: 30,
    );
}

Future<List<TipsModel>> fetchBilgilerFromDatabase(puan) async {
  var dbHelper = DBHelperTips();
  if (puan == 0) {
    Future<List<TipsModel>> bilgiler = dbHelper.getTipsBilgilerA();
    return bilgiler;
  } else if (puan == 1) {
    Future<List<TipsModel>> bilgiler = dbHelper.getTipsBilgilerB();
    return bilgiler;
  } else if (puan == -1) {
    Future<List<TipsModel>> bilgiler = dbHelper.getTipsBilgilerFavorites();
    return bilgiler;
  }
}

class _TipsState extends State<Tips> {
  var dbhelperTips = DBHelperTips();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tips"),
      ),
      body: FutureBuilder<List<TipsModel>>(
        future: fetchBilgilerFromDatabase(widget.puan),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var index1 = snapshot.data[index];
                  return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: _icon(snapshot.data[index].isFavorite),
                                  onPressed: () {
                                    if (snapshot.data[index].isFavorite ==
                                        "true") {
                                      snapshot.data[index].isFavorite = "false";
                                    } else
                                      snapshot.data[index].isFavorite = "true";

                                    snapshot.data[index].aciklama =
                                        "degistirildi";

                                    dbhelperTips
                                        .updateTips(snapshot.data[index]);
                                    (context as Element).reassemble();
                                  }),
                              Column(
                                children: [
                                  Text(
                                      "${snapshot.data[index].isFavorite}"
                                          .toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0)),
                                  Text("${snapshot.data[index].aciklama}",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0)),
                                  Text("${snapshot.data[index].kategori}",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0)),
                                ],
                              ),
                            ],
                          ),
                        )),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!

          dbhelperTips.saveTips(TipsModel(0, "aciklama", "false", "a"));

          (context as Element).reassemble();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
