import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:iknow/dailyModel.dart';
import 'package:iknow/helper/db_helperDaily.dart';
import 'package:intl/intl.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class AddDaily extends StatefulWidget {
  @override
  _AddDailyState createState() => _AddDailyState();
}

class _AddDailyState extends State<AddDaily> {
  TextEditingController _textFieldController = TextEditingController();
  double _currentSliderValue = 20;
  var radioValue1;
  var datePicked = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var counter = 0;
  int sigara;
  var kacSigara = false;
  var tebrikler = false;
  var dbHelperDaily = DBHelperDaily();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Günlük Ekle",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FlatButton(
              child: Text(
                "Kaydet",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                if (tebrikler == true) {
                  print("yapiyor");
                  var yeniGunluk = DailyModel(
                      0,
                      datePicked.toString(),
                      (!tebrikler).toString(),
                      0,
                      _currentSliderValue.toInt(),
                      counter);
                  dbHelperDaily.saveDaily(yeniGunluk);
                  Navigator.pop(context);
                } else {
                  print("yapiyor");
                  var yeniGunluk = DailyModel(
                      0,
                      datePicked.toString(),
                      (!tebrikler).toString(),
                      sigara.toInt(),
                      _currentSliderValue.toInt(),
                      counter);
                  dbHelperDaily.saveDaily(yeniGunluk);
                  Navigator.pop(context);
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
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
                    child: Text("Günlük Tarihi"),
                    onPressed: () {
                      setState(() async {
                        datePicked = await DatePicker.showSimpleDatePicker(
                          context,
                          initialDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2030),
                          dateFormat: "yyyy-MM-dd",
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
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Text("Son Kaydınızdan beri sigara içitiniz mi?"),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: CustomRadioButton(
                      width: MediaQuery.of(context).size.width / 2.5,
                      buttonLables: [
                        "Evet",
                        "Hayır",
                      ],
                      buttonValues: [
                        0,
                        1,
                      ],
                      radioButtonValue: (value) {
                        radioValue1 = value;
                        print("radioValue1 $radioValue1");
                        setState(() {
                          if (value == 1) {
                            tebrikler = true;
                            kacSigara = false;
                          } else if (value == 0) {
                            kacSigara = true;
                            tebrikler = false;
                          }
                        });
                      },
                      selectedColor: Colors.green,
                      unSelectedColor: Colors.grey,
                      enableShape: true,
                    ),
                  ),
                  Visibility(
                    visible: kacSigara,
                    child: Card(
                      child: new ListTile(
                        title: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('kaç sigara içitiniz :( $kacSigara'),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 100,
                              child: TextField(
                                onChanged: (value) {
                                  sigara = int.parse(value);
                                },
                                controller: _textFieldController,
                                decoration: InputDecoration(
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
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: tebrikler,
                    child: Card(
                      child: new ListTile(
                        title: Center(
                          child: new Text('tebrikler $tebrikler'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Ne kadar zorlandınız?"),
            SizedBox(
              height: 10,
            ),
            Slider(
              value: _currentSliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            Text("How many craving would you have"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            counter++;
                          });
                        },
                        child: Icon(Icons.add)),
                  ),
                ),
                Container(
                  width: 80,
                  height: 60,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: Text(
                        counter.toString(),
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        if (counter > 0) counter--;
                      });
                    },
                    child: Icon(Icons.remove),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
