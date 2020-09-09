import "package:flutter/material.dart";
import 'package:iknow/views/kayitSoru.dart';

class KayitScreen extends StatefulWidget {
  @override
  _KayitScreenState createState() => _KayitScreenState();
}

class _KayitScreenState extends State<KayitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: FlatButton(
                  child: Text("Şimdilik geç",
                      style: TextStyle(color: Colors.lightGreen)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => KayitSoru()));
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/cigara.jpg",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              "Hasaplarını bağla",
              style: TextStyle(fontSize: 26),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 280,
            child: Text(
              "Böylece telefonunu değiştirdiğinde veya kaybettiğinde verilerin saklanır",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 280,
            child: Text(
              "Bu uygulamayı kullandığında Gizlilik Politikası ve  şartları sözleşmeleri kabul etmiş olursun.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 280,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () => {},
                child: Text("MAİL İLE BAĞLA"),
              )),
          Container(
              width: 280,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Color(0xff4267B2),
                onPressed: () => {},
                child: Text(
                  "FACEBOOK İLE BAĞLA",
                  style: TextStyle(color: Colors.white),
                ),
              )),
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
              ))
        ],
      ),
    );
  }
}
