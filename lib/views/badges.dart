import 'package:flutter/material.dart';
import 'package:iknow/helper/db_helperBasari.dart';

import '../basariModel.dart';

class Badges extends StatefulWidget {
  @override
  _BadgesState createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  Future<List<BasariModel>> fetchBilgilerFromDatabase() async {
    var dbHelper = DBHelperBasari();

    Future<List<BasariModel>> bilgiler = dbHelper.getBasari();

    return bilgiler;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Badges",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<BasariModel>>(
            future: fetchBilgilerFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,

                  children: List.generate(snapshot.data.length, (index) {
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data[index].id.toString(),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            snapshot.data[index].aciklama,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ));
                  }),
                );
              }
            }));
  }
}
