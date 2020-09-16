import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iknow/helper/db_helperMissions.dart';
import 'package:iknow/missionModel.dart';
import 'package:iknow/views/missionPage.dart';

class Missions extends StatefulWidget {
  @override
  _MissionsState createState() => _MissionsState();
}

_icon(a) {
  if (a == "false")
    return Icon(
      Icons.check_box_outline_blank_outlined,
      color: Colors.red,
      size: 60,
    );
  else
    return Icon(
      Icons.check_box,
      color: Colors.green,
      size: 60,
    );
}

class _MissionsState extends State<Missions> {
  Future<List<MissionModel>> fetchBilgilerFromDatabase() async {
    var dbHelper = DBHelperMissions();

    Future<List<MissionModel>> bilgiler = dbHelper.getMissionsBilgiler();

    return bilgiler;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Görevler",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<MissionModel>>(
        future: fetchBilgilerFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MissionPage(
                                    id: snapshot.data[index].id,
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _icon(snapshot.data[index].tamamlandi),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 8,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data[index].baslik,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[700]),
                                          ),
                                        ),
                                      ],
                                    ),
                                    AutoSizeText(
                                      snapshot.data[index].aciklama,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
    );
  }
}
