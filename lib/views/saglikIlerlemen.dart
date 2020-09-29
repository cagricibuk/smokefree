import 'package:flutter/material.dart';
import 'package:iknow/helper/db_helper.dart';
import 'package:iknow/kayitModel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SaglikIlerlemen extends StatefulWidget {
  @override
  _SaglikIlerlemenState createState() => _SaglikIlerlemenState();
}

Future<List<KayitModel>> fetchKayitBilgilerFromDatabase() async {
  var dbHelper = DBHelper();

  Future<List<KayitModel>> bilgiler = dbHelper.getBilgiler();

  return bilgiler;
}

class _SaglikIlerlemenState extends State<SaglikIlerlemen> {
  int gecenGun;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Sağlık İlerlemelerin", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<KayitModel>>(
              future: fetchKayitBilgilerFromDatabase(),
              builder: (context, snapshot) {
                gecenGun = (DateTime.now()
                    .difference(DateTime.parse(snapshot.data[0].birakmaDate))
                    .inDays);
                if (snapshot.hasData) {
                } else if (snapshot.hasError) {
                  return new Text("${snapshot.error}");
                }
                return Text(
                  gecenGun.toString(),
                  style: TextStyle(color: Colors.lightGreen),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
