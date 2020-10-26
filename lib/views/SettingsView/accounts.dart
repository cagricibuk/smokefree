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

var dbHelperDaily = DBHelperDaily();
final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    deleteLocalDailyBilgiler();
    getAccountsDailyBilgiler();
    super.initState();
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
                  onPressed: () {},
                  child: Text(
                    "GOOGLE İLE BAĞLA",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],
        ));
  }
}
