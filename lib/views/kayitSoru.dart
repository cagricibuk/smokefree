import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:iknow/helper/db_helper.dart';
import 'package:iknow/kayitModel.dart';
import 'package:iknow/main.dart';
import 'package:intl/intl.dart';

class KayitSoru extends StatefulWidget {
  @override
  _KayitSoruState createState() => _KayitSoruState();
}

class _KayitSoruState extends State<KayitSoru> {
  DBHelper dbHelper;
  @override
  void initState() {
    dbHelper = DBHelper();

    super.initState();
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
  var datePicked, datePicked2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Kayıt Ol"),
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
                    child: Text(
                  "Uygulamayı kullanmak için hesap bilgilerinizi girin",
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
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
                  Text(datePicked == null
                      ? "tarih seçilmedi"
                      : new DateFormat("yMd").format(datePicked).toString()),
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
            Container(
                width: 280,
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

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => HomePage()));
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
