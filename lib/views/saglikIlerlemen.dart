import 'package:flutter/material.dart';
import 'package:iknow/services/db_helper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SaglikIlerlemen extends StatefulWidget {
  @override
  _SaglikIlerlemenState createState() => _SaglikIlerlemenState();
}

class _SaglikIlerlemenState extends State<SaglikIlerlemen> {
  int gecenGun;
  var gecenSaat;
  List hedefGunler = [1, 1, 1, 2, 3, 84, 270, 365, 1460, 1850, 3600, 5000];
  List kalanSureler = [];
  List kayitlar;
  List tarihler = [];
  List aciklamalar = [
    "Kalp atış hızınız ve kan basıncınız normal seviyelere düşer",
    "Karbon Monoksit oranı normalden daha düşük bir seviyeye düşer. ",
    "Kalp krizi  yaşama riskinizi %50 oranında azalttınız demektir.",
    " tat ve koku duyularınıza yardımcı olan hücreleri bu hücrelerin hızlı bir şekilde büyüdüğü görülüyor",
    "Nefes almanıza yardımcı olan tüpler gevşemeye ve iyileşmeye başlar",
    "Kan dolaşımınız normal seviyeye döner",
    "Ciğerlerinizi temizlemenize ve enfeksiyonu azaltmanıza yardımcı olur. Akciğer fonksiyonunuz % 10 kadar yükselebilir.",
    "Hem kalp hastalığı hem de kalp krizi riski sigara içenlere oranla yarı yarıya düşer. ",
    "ağız, boğaz, yemek borusu ve mesane kanserleri riskiniz, sigara içtiğiniz zamanın yarısı kadar olacaktır.",
    "inme riskiniz sigara içmeyen biri ile aynı olabilir.",
    "Akciğer kanseri riskinizi, sigara içen bir kişinin yarısı kadar düşürmek bu kadar zaman alıyor. ",
    "Hem kalp hastalığı hem de kalp krizi riskiniz artık hiç sigara içmeyen biri ile aynı."
  ];
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

  void kalanSureHesapla() {
    var gecenAy;
    var ay = 0.0, gun;
    hedefGunler.forEach((gunSayisi) {
      if (gecenGun >= gunSayisi) {
        kalanSureler.add("Tamamlandı");
      } else {
        if (gunSayisi > 30) {
          gecenAy = (gecenGun - (gecenGun % 30)) / 30;
          ay = (gecenAy - ((gunSayisi - (gunSayisi % 30)) / 30)).abs();
          gun = ((gecenGun % 30) - (gunSayisi % 30)).abs();
          if (gun != 0) {
            kalanSureler.add("${ay.toInt()} ay $gun gun kaldi");
          } else
            kalanSureler.add("${ay.toInt()} ay kaldi");
        } else {
          gun = ((gecenGun % 30) - (gunSayisi % 30)).abs();

          kalanSureler.add("$gun gun kaldi");
        }
      }
    });
  }

  void bilgilerSetup() async {
    var dbHelper = DBHelper();
    kayitlar = await dbHelper.getBilgiler();

    setState(() {
      tarihler.add(DateTime.parse(kayitlar[0].birakmaDate));
      //print(tarihler[0]);
      gecenGun = (DateTime.now().difference(tarihler[0])).inDays;
    });
    kalanSureHesapla();
  }

  @override
  void initState() {
    super.initState();
    bilgilerSetup();
    //kalanSureHesapla();
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
                  SizedBox(
                    height: 20,
                  ),
                  CircularStepProgressIndicator(
                    totalSteps: 100,
                    currentStep: sonuclama(int.parse(
                        ((100 * gecenGun) / hedefGunler[index])
                            .toStringAsFixed(0))),
                    stepSize: 10,
                    selectedColor: Colors.blue,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 15,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 30, 0, 0),
                      child: Text(
                        sonuclamaYazisi(int.parse(
                                ((100 * gecenGun) / hedefGunler[index])
                                    .toStringAsFixed(0)))
                            .toString(),
                        style: TextStyle(fontSize: 33),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    basliklar[index],
                    style: TextStyle(fontSize: 26),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Center(child: Text(aciklamalar[index]))),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    kalanSureler[index],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
