import 'package:flutter/material.dart';
import 'package:iknow/models/dailyModel.dart';
import 'package:iknow/services/db_helperDaily.dart';
import 'package:iknow/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

var currentAdi, currentSoyadi;
var dbHelperDaily = DBHelperDaily();
final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

void getAdSoyad() async {
  final User user = auth.currentUser;
  final uid = user.uid;
  print(uid);
  QuerySnapshot querySnapshot2 = await firestore.collection("users").get();
  var list2 = querySnapshot2.docs;

  list2.forEach((element) {
    if (element.id == uid) {
      currentAdi = element.get("adi");
      currentSoyadi = element.get("soyadi");
    }
  });
}

void deleteLocalDailyBilgiler() {
  print("deleting local table");
  dbHelperDaily.deleteDailyTable();
}

void getAccountsDailyBilgiler() async {
  bool res = await AuthService().loginWithGoogle();
  if (res == null) print("error logging in with google");
  final User user = auth.currentUser;
  final uid = user.uid;
  print(uid);

  QuerySnapshot querySnapshot =
      await firestore.collection("users").doc(uid).collection('daily').get();
  var list = querySnapshot.docs;
  list.forEach((element) {
    //firebase to local sql database
    print("buluttan indiriliyor...");
    var yeniGunluk = DailyModel(
        int.parse(element.id),
        element.get('tarih').toString(),
        element.get('icildiBilgileri').toString(),
        element.get('tane'),
        element.get('zorlanma'),
        element.get('cravings'));
    dbHelperDaily.saveDaily(yeniGunluk);
  });
}

class _AccountsState extends State<Accounts> {
  @override
  void initState() {
    super.initState();
    getAdSoyad();
  }

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
              "$currentAdi $currentSoyadi",
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
                  onPressed: () {
                    deleteLocalDailyBilgiler();
                    getAccountsDailyBilgiler();
                  },
                  child: Text(
                    "GOOGLE İLE BAĞLA",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],
        ));
  }
}
