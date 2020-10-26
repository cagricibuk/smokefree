import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iknow/ana.dart';
import 'package:iknow/services/shared_preference.dart';
import 'package:iknow/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  var loginValue;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    loginValue = await SharedPreferencesHelper.getRememberMeValue();
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    if (loginValue == true) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => AnaSayfa()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => OnBoardingPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 80,
            ),
            Container(
              child: Text(
                'Smoke Free',
                style: TextStyle(
                    fontFamily: "arial",
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.blueAccent[800]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
