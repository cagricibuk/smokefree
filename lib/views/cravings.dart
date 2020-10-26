import 'package:flutter/material.dart';
import 'package:iknow/views/cravings_analiz.dart';
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
  List images = [
    Image.asset(
      "assets/dosome.png",
    ),
    Image.asset(
      "assets/eat.jpg",
    ),
    Image.asset(
      "assets/relax.jpg",
    ),
    Image.asset(
      "assets/cigara.jpg",
    ),
    Image.asset(
      "assets/cigara.jpg",
    ),
    Image.asset(
      "assets/cigara.jpg",
    ),
    Image.asset(
      "assets/cigara.jpg",
    ),
    Image.asset(
      "assets/cigara.jpg",
    ),
    Image.asset(
      "assets/cigara.jpg",
    )
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
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => BarChartSample3()));
                    },
                    child: Text(
                      "Cravings Analiz Et",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: RaisedButton(
                    color: Colors.blue,
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
              height: MediaQuery.of(context).size.height / 2.3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Favorilerim",
                    style: TextStyle(fontSize: 22),
                  ),
                  Container(
                    height: 160,
                    child: Image.asset(
                      "assets/favorite.jpg",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("İpuçlarımıza göz atın veya kendinizinkini ekleyin"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2 - 80,
                      child: RaisedButton(
                        color: Colors.blue,
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
            height: MediaQuery.of(context).size.height / 4,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: new List.generate(headerList.length, (int index) {
                return new Card(
                  color: Colors.blue[index * 100],
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
                          images[index],
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
