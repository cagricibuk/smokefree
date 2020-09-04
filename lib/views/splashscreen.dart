import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iknow/ana.dart';
import 'package:iknow/helper/shared_preference.dart';
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //     image: Image.asset('images/splash.jpg').image,
          //     fit: BoxFit.cover,
          //     colorFilter: new ColorFilter.mode(
          //         Colors.black.withOpacity(0.9), BlendMode.dstATop),
          //   )),
          // ),
          Center(
            child: Container(
              child: Text(
                'Hayatı Yakala!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.yellowAccent[800]),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Yükleniyor..',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.yellowAccent[800]),
              ),
            ),
          ),

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Container(
          //       width: 180.0,
          //       height: 180.0,
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.all(Radius.circular(24.0)),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
