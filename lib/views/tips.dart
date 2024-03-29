import 'package:flutter/material.dart';
import 'package:iknow/services/db_helperTips.dart';
import 'package:iknow/models/tipsModel.dart';
import 'package:auto_size_text/auto_size_text.dart';

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

//Todo: sorduları ouana göre helperdan yapılabilir.
// ignore: missing_return
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
                  return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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

                                    dbhelperTips
                                        .updateTips(snapshot.data[index]);
                                    // ignore: invalid_use_of_protected_member
                                    (context as Element).reassemble();
                                  }),
                              // AutoSizeText(
                              //     "${snapshot.data[index].isFavorite}"
                              //         .toString(),
                              //     style: new TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 14.0)),
                              Flexible(
                                child: AutoSizeText(
                                    "${snapshot.data[index].aciklama}",
                                    style: new TextStyle(fontSize: 14.0)),
                              ),
                              // Text("${snapshot.data[index].kategori}",
                              //     style: new TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 14.0)),
                            ],
                          ),
                        )),
                  );
                });
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

          // ignore: invalid_use_of_protected_member
          (context as Element).reassemble();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
