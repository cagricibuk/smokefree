import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iknow/helper/shared_preference.dart';
import 'package:iknow/kayitModel.dart';
import 'package:iknow/views/fagerstrom.dart';
import 'package:iknow/views/kayitScreen.dart';
import 'package:iknow/views/saveFor.dart';
import 'package:iknow/views/splashscreen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'helper/db_helper.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: SplashScreen(), //ilk sayfa
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    SharedPreferencesHelper.setRememberMeValue(true);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => KayitScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 200.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Sigarayı Atın Hayatı Tadın",
          body:
              " Bir sigarada, 4.800’ün üzerinde kimyasal bulunuyor ve bunların 69’unun kansere yol açtığı biliniyor.",
          image: _buildImage('cigara'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Sigarayı Dışla, Hayata Yeniden Başla ",
          body: "Sigara içenlerin %69‘u sigarayı bırakabilmek istiyor.",
          image: _buildImage('img2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Sevdiklerin İçin Bağımlı Olma",
          body: "İçtiğiniz her sigara ömrünüzü 11 dakika kadar kısaltıyor.",
          image: _buildImage('img3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bağımsızım, Hayatı Seviyorum",
          body:
              "Her gün 85.000 civarında genç sigaraya başlıyor ve 22.000’den fazlası da sigara bağımlısı oluyor.",
          image: _buildImage('img2'),
          // footer: RaisedButton(
          //   onPressed: () {
          //     introKey.currentState?.animateScroll(0);
          //   },
          //   child: const Text(
          //     'FooButton',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   color: Colors.lightGreen,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          // ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: " Sağlıklı bir hayat sizin elinizde!",
          body:
              "Bir sigarada, 4.800’ün üzerinde kimyasal bulunuyor ve bunların 69’unun kansere yol açtığı biliniyor.",
          // bodyWidget: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Text("Click on ", style: bodyStyle),
          //     Icon(Icons.edit),
          //     Text(" to edit a post", style: bodyStyle),
          //   ],
          // ),
          image: _buildImage('img2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: " Maddeyi Kabul Etmek Kolay, Bırakmak Zordur",
          body: "",

          // bodyWidget: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Text("Click on ", style: bodyStyle),
          //     Icon(Icons.edit),
          //     Text(" to edit a post", style: bodyStyle),
          //   ],
          // ),
          image: _buildImage('img2'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Atla'),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        'Bitti',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.lightGreen,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

Future<List<KayitModel>> fetchBilgilerFromDatabase() async {
  var dbHelper = DBHelper();

  Future<List<KayitModel>> bilgiler = dbHelper.getBilgiler();

  return bilgiler;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<KayitModel>> liste = fetchBilgilerFromDatabase();

  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Column(
            children: [
              AlertDialog(
                title: Text('Yeni mottonuzu giriniz'),
                content: TextField(
                  controller: _textFieldController,
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(hintText: "Mottonuzu girin"),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('Submit'),
                    onPressed: () {
                      SharedPreferencesHelper.setMottoValue(
                          _textFieldController.text);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightGreen[600],
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.assessment,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => FagerStrom()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // Container(
          //   padding: new EdgeInsets.all(16.0),
          //   child: FutureBuilder<List<KayitModel>>(
          //     future: fetchBilgilerFromDatabase(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //       } else if (snapshot.hasError) {
          //         return new Text("${snapshot.error}");
          //       }
          //       return Container(
          //         child: Column(
          //           children: [
          //             Text(snapshot.data[0].adi),
          //             Text(snapshot.data[0].soyadi),
          //             Text(snapshot.data[0].id.toString()),
          //             Text(snapshot.data[0].fiyat.toString()),
          //             Text(snapshot.data[0].gunlukIcme.toString()),
          //             Text(snapshot.data[0].birakmaDate.toString()),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: AssetImage("assets/arka1.png"),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: RaisedButton(
              color: Colors.transparent,
              onPressed: () {},
              child: FutureBuilder<List<KayitModel>>(
                future: fetchBilgilerFromDatabase(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                  } else {
                    return new Text("${snapshot.error}");
                  }

                  return Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sigarasız Geçen Gün",
                          style: TextStyle(fontSize: 26, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //new DateFormat("yMd").format(datePicked)
                        Text(
                          DateTime.now()
                              .difference(
                                  DateTime.parse(snapshot.data[0].birakmaDate))
                              .inDays
                              .toString(),
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          height: 40,
                          width: 120,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            onPressed: null,
                            child: Text(
                              "EXPLORE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: RaisedButton(
              color: Colors.white,
              onPressed: () {},
              child: FutureBuilder<List<KayitModel>>(
                  future: fetchBilgilerFromDatabase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                    } else if (snapshot.hasError) {
                      return new Text("${snapshot.error}");
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Paradan Tasarruf",
                          style: TextStyle(fontSize: 26, color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "₺${(DateTime.now().difference(DateTime.parse(snapshot.data[0].birakmaDate)).inDays * (snapshot.data[0].gunlukIcme * snapshot.data[0].fiyat / 20)).toStringAsFixed(1).toString()}",
                          style:
                              TextStyle(fontSize: 50, color: Colors.lightGreen),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Yıllık Tasarruf",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "₺${((DateTime.now().difference(DateTime.parse(snapshot.data[0].birakmaDate)).inDays * (snapshot.data[0].gunlukIcme * snapshot.data[0].fiyat / 20)) * 365).toStringAsFixed(1).toString()}",
                          style:
                              TextStyle(fontSize: 25, color: Colors.lightGreen),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 120,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            onPressed: null,
                            child: Text(
                              "EXPLORE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SaveFor()));
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Bir şeyler için biriktir",
                    style: TextStyle(fontSize: 26, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 250,
                        child: Container(
                          width: 60,
                          child: Text(
                              "Sigaradan tassaruf ettiğin parayla almak istediğin şeyleri belirle"),
                        ),
                      ),
                      Image.asset(
                        'assets/biket.png',
                        width: 60,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      onPressed: null,
                      child: Text(
                        "EXPLORE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: RaisedButton(
              color: Colors.white,
              onPressed: () {},
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sağlık  İlerlemen",
                    style: TextStyle(fontSize: 26, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Rahat Nefes "),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: FutureBuilder<List<KayitModel>>(
                              future: fetchBilgilerFromDatabase(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                } else if (snapshot.hasError) {
                                  return new Text("${snapshot.error}");
                                }
                                return CircularStepProgressIndicator(
                                  totalSteps: 100,
                                  currentStep: (((DateTime.now()
                                                  .difference(DateTime.parse(
                                                      snapshot
                                                          .data[0].birakmaDate))
                                                  .inDays) *
                                              100) ~/
                                          72)
                                      .toInt(),
                                  stepSize: 10,
                                  selectedColor: Colors.lightGreen,
                                  unselectedColor: Colors.grey[200],
                                  padding: 0,
                                  width: 80,
                                  height: 80,
                                  selectedStepSize: 15,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 15, 0, 0),
                                    child: Text(
                                      (((DateTime.now()
                                                      .difference(
                                                          DateTime.parse(
                                                              snapshot.data[0]
                                                                  .birakmaDate))
                                                      .inDays) *
                                                  100) ~/
                                              72)
                                          .toInt()
                                          .toString(),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          AutoSizeText(
                            "Karbonmonoksit Değeri",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: FutureBuilder<List<KayitModel>>(
                              future: fetchBilgilerFromDatabase(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                } else if (snapshot.hasError) {
                                  return new Text("${snapshot.error}");
                                }
                                return CircularStepProgressIndicator(
                                  totalSteps: 100,
                                  currentStep: (((DateTime.now()
                                                  .difference(DateTime.parse(
                                                      snapshot
                                                          .data[0].birakmaDate))
                                                  .inDays) *
                                              100) ~/
                                          24)
                                      .toInt(),
                                  stepSize: 10,
                                  selectedColor: Colors.lightGreen,
                                  unselectedColor: Colors.grey[200],
                                  padding: 0,
                                  width: 80,
                                  height: 80,
                                  selectedStepSize: 15,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 15, 0, 0),
                                    child: Text(
                                      (((DateTime.now()
                                                      .difference(
                                                          DateTime.parse(
                                                              snapshot.data[0]
                                                                  .birakmaDate))
                                                      .inDays) *
                                                  100) ~/
                                              24)
                                          .toInt()
                                          .toString(),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Nikotin"),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: FutureBuilder<List<KayitModel>>(
                              future: fetchBilgilerFromDatabase(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                } else if (snapshot.hasError) {
                                  return new Text("${snapshot.error}");
                                }
                                return CircularStepProgressIndicator(
                                  totalSteps: 100,
                                  currentStep: (((DateTime.now()
                                                  .difference(DateTime.parse(
                                                      snapshot
                                                          .data[0].birakmaDate))
                                                  .inDays) *
                                              100) ~/
                                          48)
                                      .toInt(),
                                  stepSize: 10,
                                  selectedColor: Colors.lightGreen,
                                  unselectedColor: Colors.grey[200],
                                  padding: 0,
                                  width: 80,
                                  height: 80,
                                  selectedStepSize: 15,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 15, 0, 0),
                                    child: Text(
                                      (((DateTime.now()
                                                      .difference(
                                                          DateTime.parse(
                                                              snapshot.data[0]
                                                                  .birakmaDate))
                                                      .inDays) *
                                                  100) ~/
                                              48)
                                          .toInt()
                                          .toString(),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      onPressed: null,
                      child: Text(
                        "EXPLORE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage("assets/arka1.png"), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: RaisedButton(
              color: Colors.transparent,
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FutureBuilder<String>(
                    future: SharedPreferencesHelper
                        .getMottoValue(), // a previously-obtained Future<String> or null
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        children = <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: AutoSizeText(
                                  '${snapshot.data}',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  maxLines: 2,
                                ),
                              )),
                        ];
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          )
                        ];
                      } else {
                        children = <Widget>[
                          SizedBox(
                            child: CircularProgressIndicator(),
                            width: 60,
                            height: 60,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          )
                        ];
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: children,
                        ),
                      );
                    },
                  ),

                  // Text(
                  //   SharedPreferencesHelper.getMottoValue(),
                  //   style: TextStyle(fontSize: 22, color: Colors.black),
                  // ),

                  Column(
                    children: [
                      Container(
                        height: 40,
                        width: 220,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          onPressed: () {
                            _displayDialog(context);
                          },
                          child: Text(
                            "KENDİ MESAJINI EKLE",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: RaisedButton(
              color: Colors.white,
              onPressed: () {},
              child: FutureBuilder<List<KayitModel>>(
                  future: fetchBilgilerFromDatabase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                    } else if (snapshot.hasError) {
                      return new Text("${snapshot.error}");
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "İlerlemen",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "İçilmeyen sigaralar",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    AutoSizeText(
                                      (DateTime.now()
                                                  .difference(DateTime.parse(
                                                      snapshot
                                                          .data[0].birakmaDate))
                                                  .inDays *
                                              snapshot.data[0].gunlukIcme)
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.lightGreen),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sigara İsteğine direnme",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.lightGreen),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sigara içmeden geçen süre(saat)",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    AutoSizeText(
                                      (DateTime.now()
                                              .difference(DateTime.parse(
                                                  snapshot.data[0].birakmaDate))
                                              .inHours)
                                          .toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.lightGreen),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ]),
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: FabCircularMenu(
            fabOpenIcon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            fabCloseIcon: Icon(Icons.close, color: Colors.white),
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.today,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print('Diary daily');
                  }),
              IconButton(
                  icon: Icon(Icons.trending_down, color: Colors.white),
                  onPressed: () {
                    print('Cravings');
                  })
            ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            title: Text('Baş Etme'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            title: Text('Başarılar'),
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.lightGreen,
      ),
    );
  }
}
