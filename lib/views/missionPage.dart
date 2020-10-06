import 'package:flutter/material.dart';
import 'package:iknow/ana.dart';
import 'package:iknow/helper/db_helperMissions.dart';
import 'package:iknow/missionModel.dart';

// ignore: must_be_immutable
class MissionPage extends StatefulWidget {
  int id;
  MissionPage({this.id});
  @override
  _MissionPageState createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  Future<List<MissionModel>> fetchBilgilerFromDatabase() async {
    var dbHelper = DBHelperMissions();

    Future<List<MissionModel>> bilgiler = dbHelper.getMissionsByID(widget.id);

    return bilgiler;
  }

  var dbHelper = DBHelperMissions();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MissionModel>>(
      future: fetchBilgilerFromDatabase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                color: Colors.white,
                onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnaSayfa(
                        indis: 3,
                      ),
                    ),
                  )
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: (snapshot.data[0].baslik) != null
                  ? Text(
                      "${snapshot.data[0].baslik}",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text("boş"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(children: [
                  Text(
                    "Bugünkü görevin",
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  snapshot.data[0].aciklama != null
                      ? Text("${snapshot.data[0].aciklama}",
                          style: TextStyle(fontSize: 17, color: Colors.black))
                      : Text("Boş"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 280,
                      child: RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          snapshot.data[0].tamamlandi = "true";
                          dbHelper.updateMissions(snapshot.data[0]);

                          //ana sayfada 3. indisli sayfayı aç
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnaSayfa(
                                indis: 3,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Tamamlandı Olarak İşaretle",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Container(
                      width: 280,
                      child: RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          snapshot.data[0].tamamlandi = "false";
                          dbHelper.updateMissions(snapshot.data[0]);

                          //ana sayfada 3. indisli sayfayı aç
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnaSayfa(
                                indis: 3,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Tamamlanmadı Olarak İşaretle",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ]),
              ),
            ),
          );
        } else {
          return Text(snapshot.error);
        }
      },
    );
  }
}
