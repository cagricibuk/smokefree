import 'package:flutter/material.dart';
import 'package:iknow/ana.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'fagerstrom.dart';

// ignore: must_be_immutable
class FagerSonuc extends StatefulWidget {
  int puan;
  FagerSonuc({this.puan});

  @override
  _FagerSonucState createState() => _FagerSonucState();
}

class _FagerSonucState extends State<FagerSonuc> {
  String mesaj;
  @override
  void initState() {
    super.initState();
    if (widget.puan <= 2) {
      mesaj = "Çok düşük";
    } else if (widget.puan <= 4 && widget.puan > 2) {
      mesaj = "Düşük";
    } else if (widget.puan <= 6 && widget.puan > 4) {
      mesaj = "Orta";
    } else if (widget.puan <= 8 && widget.puan > 6) {
      mesaj = "Yüksek";
    } else
      mesaj = "Çok Yüksek";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Analiz Sonucu",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              color: Colors.grey[200],
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        children: [
                          AutoSizeText(
                            "Bağımlılık seviyesi",
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            mesaj,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 1.7,
                      child: StepProgressIndicator(
                        progressDirection: TextDirection.rtl,
                        direction: Axis.vertical,
                        totalSteps: 10,
                        currentStep: widget.puan,
                        selectedColor: Colors.red,
                        unselectedColor: Colors.lightGreen,
                        customSize: (index) => (index + 1) * 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: 280,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.lightGreen,
                  onPressed: () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => FagerStrom())),
                  },
                  child: Text(
                    "Testi Tekrar Başlat",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 280,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.lightBlue,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AnaSayfa()),
                        ModalRoute.withName('/'));
                  },
                  child: Text(
                    "Anasayfaya Dön",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
