import 'package:flutter/material.dart';
import 'package:iknow/cravings.dart';
import 'package:iknow/views/missions.dart';
import 'package:iknow/views/takvimAna.dart';
import 'main.dart';

// ignore: must_be_immutable
class AnaSayfa extends StatefulWidget {
  int indis;
  AnaSayfa({this.indis});
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomePage(), MyApp(), Cravings(), Missions()];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.indis != null) _currentIndex = widget.indis;
  }

// deneme
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, //
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Panel'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Günlük'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_down),
            title: Text('Aşerme'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            title: Text('Görevler'),
          ),
        ],

        selectedItemColor: Colors.lightGreen,
      ),
    );
  }
}
