import 'package:flutter/material.dart';

class AddCravings extends StatefulWidget {
  @override
  _AddCravingsState createState() => _AddCravingsState();
}

class _AddCravingsState extends State<AddCravings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cravings Ekle"),
      ),
    );
  }
}
