import 'package:flutter/material.dart';
import 'package:iknow/cravings.dart';
import 'package:iknow/views/daily.dart';
import 'package:iknow/views/fagerstrom.dart';
import 'package:iknow/views/saveFor.dart';

import 'main.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    Daily(),
    Cravings(),
    FagerStrom()
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
            title: Text('Başarılar'),
          ),
        ],

        selectedItemColor: Colors.lightGreen,
      ),
    );
  }
}
