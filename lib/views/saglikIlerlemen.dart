import 'package:flutter/material.dart';
import 'package:iknow/helper/db_helper.dart';
import 'package:iknow/kayitModel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SaglikIlerlemen extends StatefulWidget {
  @override
  _SaglikIlerlemenState createState() => _SaglikIlerlemenState();
}

class _SaglikIlerlemenState extends State<SaglikIlerlemen> {
  int gecenGun;
  var gecenSaat;
  List hedefGunler = [1, 1, 1, 2, 3, 84, 270, 365, 1460, 1850, 3600, 5000];
  List kayitlar;
  List tarihler = [];
  List basliklar = [
    "Nabız ve Kan Basıncı",
    "Karbon Monoksit",
    "Kalp Krizi Riski",
    "Koku ve Tat Duygusu",
    "Bronş Tüpleri",
    "Kan Dolaşımı",
    "Akciğer Fonksiyonu",
    "Kalp Sağlığı",
    "Kanser",
    "İnme",
    "Akciğer Kanseri",
    "Kalp Hastalığı"
  ];

  int sonuclama(sayi) {
    if (sayi > 100) {
      return 100;
    } else
      return sayi;
  }

  String sonuclamaYazisi(sayi) {
    if (sayi > 100)
      return "%100";
    else
      return "%$sayi";
  }

  void bilgilerSetup() async {
    var dbHelper = DBHelper();
    kayitlar = await dbHelper.getBilgiler();

    setState(() {
      tarihler.add(DateTime.parse(kayitlar[0].birakmaDate));
      //print(tarihler[0]);
      gecenGun = (DateTime.now().difference(tarihler[0])).inDays;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bilgilerSetup();
    print("İnit");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Sağlık İlerlemelerin", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: hedefGunler.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Text(basliklar[index]),
                  SizedBox(height: 20),
                  CircularStepProgressIndicator(
                    totalSteps: 100,
                    currentStep: sonuclama(int.parse(
                        ((100 * gecenGun) / hedefGunler[index])
                            .toStringAsFixed(0))),
                    stepSize: 10,
                    selectedColor: Colors.lightGreen,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 15,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 30, 0, 0),
                      child: Text(
                        sonuclamaYazisi(int.parse(
                                ((100 * gecenGun) / hedefGunler[index])
                                    .toStringAsFixed(0)))
                            .toString(),
                        style: TextStyle(fontSize: 36),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
