import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:iknow/ana.dart';
import 'package:iknow/basariModel.dart';
import 'package:iknow/helper/db_helper.dart';
import 'package:iknow/helper/db_helperBasari.dart';
import 'package:iknow/helper/db_helperMissions.dart';
import 'package:iknow/helper/db_helperTips.dart';
import 'package:iknow/kayitModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:iknow/missionModel.dart';
import 'package:intl/intl.dart';

import '../tipsModel.dart';

class KayitSoru extends StatefulWidget {
  @override
  _KayitSoruState createState() => _KayitSoruState();
}

class _KayitSoruState extends State<KayitSoru> {
  DBHelper dbHelper;
  var dbHelperBasari = DBHelperBasari();
  var dbhelperTips = DBHelperTips();
  // ignore: unused_field
  List<String> _badges = [];
  // ignore: unused_field
  List<String> _tips = [];
  var dbhelperMissions = DBHelperMissions();
  // ignore: unused_field
  List<String> _missions = [];
  @override
  void initState() {
    dbHelper = DBHelper();
    dbhelperMissions = DBHelperMissions();
    dbhelperTips = DBHelperTips();
    _setup();
    super.initState();
  }

  Future<List<String>> _loadTips() async {
    List<String> tips = [];
    await rootBundle.loadString('assets/tips.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        tips.add(i);
      }
    });
    return tips;
  }

  Future<List<String>> _loadMissions() async {
    List<String> missions = [];
    await rootBundle.loadString('assets/missions.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        missions.add(i);
      }
    });
    return missions;
  }

  Future<List<String>> _loadBadges() async {
    List<String> badges = [];
    await rootBundle.loadString('assets/badges.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        badges.add(i);
      }
    });
    return badges;
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    List<String> tips = await _loadTips();
    List<String> missions = await _loadMissions();
    List<String> badges = await _loadBadges();

    // Notify the UI and display the questions
    setState(() {
      _tips = tips;
      _missions = missions;
      _badges = badges;
    });
    for (var i = 0; i < tips.length; i++) {
      if (i < 9)
        dbhelperTips.saveTips(TipsModel(0, tips[i], "false", "a"));
      else
        dbhelperTips.saveTips(TipsModel(0, tips[i], "false", "b"));
    }
    for (var i = 0; i < missions.length; i++) {
      dbhelperMissions
          .saveMissions(MissionModel(0, "baslik $i", missions[i], "false"));
    }
    for (var i = 0; i < badges.length; i++) {
      dbHelperBasari.saveBasari(BasariModel(0, badges[i], "a", "yok", "false"));
    }
  }

  TextEditingController adiController = TextEditingController();
  TextEditingController soyadiController = TextEditingController();
  TextEditingController ilController = TextEditingController();
  TextEditingController fiyatController = TextEditingController();
  TextEditingController adetController = TextEditingController();
  TextEditingController yilController = TextEditingController();
  TextEditingController istekController = TextEditingController();

  // var yeniKayıt = new KayitModel(adi, soyadi, il, fiyat, gunlukIcme, icmeYil, birakmaIstegi, birthDate, id)
  int _value = 1;
  var datePicked;
  var datePicked2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Kayıt Ol",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                    child: AutoSizeText(
                  "Uygulamayı kullanmak için hesap bilgilerinizi girin",
                  style: TextStyle(color: Colors.grey[600]),
                  maxLines: 1,
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: adiController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Ad',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.grey[300],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: soyadiController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Soyad',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.grey[300],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: ilController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  hintText: 'Yaşadığınız il',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.grey[300],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: fiyatController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.euro_symbol),
                  hintText: 'Sigara paket fiyatı',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.grey[300],
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: adetController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.crop_square),
                  hintText: 'Günde kaç adet içiyorsunuz?',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.grey[300],
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: yilController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.history),
                  hintText: 'Kaç yıldır içiyorsunuz?',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.grey[300],
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: istekController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.star),
                  hintText: 'Bırakma isteğiniz (10 üzerinden)',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.grey[300],
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(datePicked == null
                      ? "tarih seçilmedi"
                      : new DateFormat("yMd").format(datePicked).toString()),
                  RaisedButton(
                    child: Text("Doğum Tarihi"),
                    onPressed: () {
                      setState(() async {
                        datePicked = await DatePicker.showSimpleDatePicker(
                          context,
                          initialDate: DateTime(1960),
                          firstDate: DateTime(1960),
                          lastDate: DateTime(2022),
                          dateFormat: "yyyy-MM-dd",
                          locale: DateTimePickerLocale.tr,
                          looping: true,
                        );
                        if (datePicked == null) {
                          datePicked = DateTime.now();
                        }
                        print(new DateFormat("yMd").format(datePicked));
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(datePicked2 == null
                      ? "tarih seçilmedi"
                      : new DateFormat("yMd").format(datePicked2).toString()),
                  RaisedButton(
                    child: Text("Bırakma Tarihi"),
                    onPressed: () {
                      setState(() async {
                        datePicked2 = await DatePicker.showSimpleDatePicker(
                          context,
                          initialDate: DateTime(1960),
                          firstDate: DateTime(1960),
                          lastDate: DateTime(2022),
                          dateFormat: "yyyy-MM-dd",
                          locale: DateTimePickerLocale.tr,
                          looping: true,
                        );
                        if (datePicked2 == null) {
                          datePicked2 = DateTime.now();
                        }
                        print(new DateFormat("yMd").format(datePicked2));
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Daha önce bırakmayı denediniz mi? "),
                  DropdownButton(
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text("Evet"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Hayır"),
                          value: 2,
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: RaisedButton(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.green,
                  onPressed: () {
                    var yeniKayit = KayitModel(
                      adiController.text,
                      soyadiController.text,
                      ilController.text,
                      int.parse(fiyatController.text),
                      int.parse(adetController.text),
                      int.parse(yilController.text),
                      datePicked.toString(),
                      datePicked2.toString(),
                      0,
                    );

                    dbHelper.save(yeniKayit);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AnaSayfa()),
                        ModalRoute.withName('/'));
                  },
                  child: Text(
                    "Kaydı Tamamla",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}
