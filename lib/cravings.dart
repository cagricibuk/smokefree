import 'package:flutter/material.dart';
import 'package:iknow/views/tips.dart';

class Cravings extends StatefulWidget {
  @override
  _CravingsState createState() => _CravingsState();
}

class _CravingsState extends State<Cravings> {
  List headerList = [
    "Do something",
    "Eat something",
    "Relax",
    "Reward Yourself",
    "Benefits",
    "Mantras",
    "Our Suggestions",
    "Cues",
    "Sources"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cravings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () => {},
                    child: Text(
                      "Cravings Analiz Et",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () => {},
                    child: Text(
                      "Cravings Ekle",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
          Card(
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 160,
                    child: Image.asset(
                      "assets/cigara.jpg",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("İpuçlarımıza göz atın veya kendinizinkini ekleyin"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2 - 80,
                      child: RaisedButton(
                        color: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tips(
                                      puan: -1,
                                    )),
                          );
                        },
                        child: Text(
                          "Explore",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Container(
            height: 180.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: new List.generate(headerList.length, (int index) {
                return new Card(
                  color: Colors.lightGreen[index * 100],
                  child: new Container(
                    width: 150.0,
                    height: 50.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Tips(
                                    puan: index,
                                  )),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/cigara.jpg",
                          ),
                          new Text("${headerList[index]}"),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}