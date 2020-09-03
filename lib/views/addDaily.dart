import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class AddDaily extends StatefulWidget {
  @override
  _AddDailyState createState() => _AddDailyState();
}

class _AddDailyState extends State<AddDaily> {
  double _currentSliderValue = 20;
  var radioValue1;
  var datePicked;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Günlük Ekle",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
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
                  child: Text("Doğum Tarihi"),
                  onPressed: () {
                    setState(() async {
                      datePicked = await DatePicker.showSimpleDatePicker(
                        context,
                        initialDate: DateTime(1960),
                        firstDate: DateTime(1960),
                        lastDate: DateTime(2022),
                        dateFormat: "yyyy-MM-dd",
                        looping: true,
                      );
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
                      print("radioValue2 $radioValue1");
                    },
                    selectedColor: Colors.green,
                    unSelectedColor: Colors.grey,
                    enableShape: true,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  width: 50,
                  height: 50,
                  child: RaisedButton(onPressed: () {}, child: Icon(Icons.add)),
                ),
              ),
              Container(
                width: 80,
                height: 60,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: RaisedButton(
                  onPressed: () {},
                  child: Icon(Icons.remove),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
