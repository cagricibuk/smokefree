import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:iknow/helper/db_helper.dart';
import 'package:iknow/helper/db_helperSF.dart';
import 'package:iknow/helper/saveForModel.dart';
import 'package:iknow/kayitModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SaveFor extends StatefulWidget {
  @override
  _SaveForState createState() => _SaveForState();
}

TextEditingController adiController = TextEditingController();
TextEditingController aciklamaController = TextEditingController();
TextEditingController fiyatController = TextEditingController();

Future<List<SaveForModel>> fetchBilgilerFromDatabase() async {
  var dbHelper = DBHelperSF();

  Future<List<SaveForModel>> bilgiler = dbHelper.getSaveForBilgiler();

  return bilgiler;
}

/////
Future<List<KayitModel>> fetchKayitBilgilerFromDatabase() async {
  var dbHelper = DBHelper();

  Future<List<KayitModel>> bilgiler = dbHelper.getBilgiler();

  return bilgiler;
}

class _SaveForState extends State<SaveFor> {
  _openPopup(context) {
    Alert(
        context: context,
        title: "Biriktirme Hedefi",
        content: Column(
          children: <Widget>[
            TextField(
              controller: adiController,
              decoration: InputDecoration(
                labelText: 'Adı',
              ),
            ),
            TextField(
              controller: aciklamaController,
              decoration: InputDecoration(
                labelText: 'Açıklaması',
              ),
            ),
            TextField(
              controller: fiyatController,
              decoration: InputDecoration(
                //      hintText: "0 dan büyük olmalıdır",
                labelText: 'Fiyatı',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if ((int.parse(fiyatController.text)) < 1) {
                fiyatController.text = "0 degeri uygun degildir";
              } else {
                var dbHelper = DBHelperSF();
                var item = SaveForModel(0, adiController.text,
                    aciklamaController.text, int.parse(fiyatController.text));
                dbHelper.saveSaveFors(item);
                adiController.text = "";
                aciklamaController.text = "";
                fiyatController.text = "";

                Navigator.pop(context);
                // ignore: invalid_use_of_protected_member
                (context as Element).reassemble();
              }
            },
            child: Text(
              "EKLE",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }

  DBHelperSF dbHelper;

  List fiyats;
  int currentIndex = 0;
  @override
  void initState() {
    dbHelper = DBHelperSF();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Bir Şeyler İçin Biriktir",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Elde Edilen"),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder<List<SaveForModel>>(
                        future: fetchBilgilerFromDatabase(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                          } else if (snapshot.hasError) {
                            return new Text("${snapshot.error}");
                          }
                          return Text(
                            "0/${snapshot.data.length}",
                            style: TextStyle(color: Colors.lightGreen),
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Günlük Tasarruf"),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder<List<KayitModel>>(
                        future: fetchKayitBilgilerFromDatabase(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                          } else if (snapshot.hasError) {
                            return new Text("${snapshot.error}");
                          }
                          return Text(
                            "₺${(snapshot.data[0].gunlukIcme * snapshot.data[0].fiyat / 20).toString()}",
                            style: TextStyle(color: Colors.lightGreen),
                          );
                        },
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("Toplam Tasarruf"),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder<List<KayitModel>>(
                        future: fetchKayitBilgilerFromDatabase(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                          } else if (snapshot.hasError) {
                            return new Text("${snapshot.error}");
                          }
                          return Text(
                            "₺${(DateTime.now().difference(DateTime.parse(snapshot.data[0].birakmaDate)).inDays * (snapshot.data[0].gunlukIcme * snapshot.data[0].fiyat / 20)).toStringAsFixed(1)}",
                            style: TextStyle(color: Colors.lightGreen),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 520,
                ///////////////////////////////////////////////////////
                child: FutureBuilder<List<SaveForModel>>(
                  future: fetchBilgilerFromDatabase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return new ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var index1 = snapshot.data[index];
                            return Dismissible(
                              background: Container(
                                alignment: AlignmentDirectional.centerEnd,
                                color: Colors.red,
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
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
                                  dbHelper
                                      .deleteSaveFor(snapshot.data[index].id);
                                });

                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "${snapshot.data[index].adi} silindi")));
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                child: FutureBuilder<
                                                    List<KayitModel>>(
                                              future:
                                                  fetchKayitBilgilerFromDatabase(),
                                              // ignore: missing_return
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return CircularStepProgressIndicator(
                                                    totalSteps: index1.fiyat,
                                                    currentStep: (DateTime.now()
                                                            .difference(DateTime
                                                                .parse(snapshot
                                                                    .data[0]
                                                                    .birakmaDate))
                                                            .inDays) *
                                                        snapshot.data[0]
                                                            .gunlukIcme *
                                                        snapshot
                                                            .data[0].fiyat ~/
                                                        20,
                                                    stepSize: 10,
                                                    selectedColor:
                                                        Colors.lightGreen,
                                                    unselectedColor:
                                                        Colors.grey[200],
                                                    padding: 0,
                                                    width: 80,
                                                    height: 80,
                                                    selectedStepSize: 15,
                                                    child: Icon(
                                                      Icons.circle,
                                                      color: Colors.grey,
                                                      size: 50,
                                                    ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return new Text(
                                                      "${snapshot.error}");
                                                }
                                              },
                                            )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                new Text(
                                                    snapshot.data[index].adi,
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18.0)),
                                                new Text(
                                                    snapshot
                                                        .data[index].aciklama,
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0)),
                                              ],
                                            ),
                                          ]),
                                      Column(
                                        children: [
                                          Text(
                                              "₺${snapshot.data[index].fiyat}"
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
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openPopup(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
