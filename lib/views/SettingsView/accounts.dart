import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

void getAccountsBilgiler() {}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hesap Ayarları")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 14, width: MediaQuery.of(context).size.width),
            CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Adi Soyadi",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 280,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Color(0xffDB4437),
                  onPressed: () => {},
                  child: Text(
                    "GOOGLE İLE BAĞLA",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],
        ));
  }
}
