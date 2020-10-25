import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:iknow/helper/shared_preference.dart';
import 'package:iknow/kayitModel.dart';
import 'package:iknow/views/addDaily.dart';
import 'package:iknow/views/badges.dart';
import 'package:iknow/views/fagerstrom.dart';
import 'package:iknow/views/kayitScreen.dart';
import 'package:iknow/views/saglikIlerlemen.dart';
import 'package:iknow/views/saveFor.dart';
import 'package:iknow/views/SettingsView/settings.dart';
import 'package:iknow/views/splashscreen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'basariModel.dart';
import 'helper/db_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helper/db_helperBasari.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
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
          //   color: Colors.blue,
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
        activeColor: Colors.blue,
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

int sonuclama(sayi) {
  if (sayi > 100) {
    return 100;
  } else
    return sayi;
}

String sonuclamaYazisi(sayi) {
  if (sayi > 100)
    return "%100";
  else
    return "%$sayi";
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _hideFabAnimation;
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  initState() {
    super.initState();
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    _hideFabAnimation.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  Future<List<KayitModel>> liste = fetchBilgilerFromDatabase();

  TextEditingController _textFieldController = TextEditingController();
  Future<List<BasariModel>> fetchBadgesFromDatabase() async {
    var dbHelper = DBHelperBasari();

    Future<List<BasariModel>> bilgiler = dbHelper.getBasari();

    return bilgiler;
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Yeni Motto",
        content: Column(
          children: <Widget>[
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                labelText: 'Mottonuzu girin',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              SharedPreferencesHelper.setMottoValue(_textFieldController.text);
              Navigator.pop(context);
              // ignore: invalid_use_of_protected_member
              (context as Element).reassemble();
            },
            child: Text(
              "EKLE",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue, // status bar color
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
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SettingsPage()));
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
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
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sigarasız Geçen Gün",
                              style:
                                  TextStyle(fontSize: 26, color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //new DateFormat("yMd").format(datePicked)
                            Text(
                              DateTime.now()
                                  .difference(DateTime.parse(
                                      snapshot.data[0].birakmaDate))
                                  .inDays
                                  .toString(),
                              style:
                                  TextStyle(fontSize: 50, color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return new Center(child: CircularProgressIndicator());
                    }
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
                      } else {
                        return new Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Paradan Tasarruf",
                            style: TextStyle(fontSize: 26, color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if ((DateTime.now()
                                          .difference(DateTime.parse(
                                              snapshot.data[0].birakmaDate))
                                          .inDays *
                                      (snapshot.data[0].gunlukIcme *
                                          snapshot.data[0].fiyat /
                                          20))
                                  .toStringAsFixed(1)
                                  .toString() ==
                              null)
                            Center(child: CircularProgressIndicator())
                          else
                            Text(
                              "₺${(DateTime.now().difference(DateTime.parse(snapshot.data[0].birakmaDate)).inDays * (snapshot.data[0].gunlukIcme * snapshot.data[0].fiyat / 20)).toStringAsFixed(1).toString()}",
                              style:
                                  TextStyle(fontSize: 50, color: Colors.blue),
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
                            "₺${((snapshot.data[0].gunlukIcme * snapshot.data[0].fiyat / 20) * 365).toStringAsFixed(1).toString()}",
                            style: TextStyle(fontSize: 25, color: Colors.blue),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            Container(
              height: 200,
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
                color: Colors.blue,
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
                      style: TextStyle(fontSize: 26, color: Colors.white),
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
                            child: AutoSizeText(
                              "Sigaradan tassaruf ettiğin parayla almak istediğin şeyleri belirle",
                              style: TextStyle(color: Colors.white),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/biket.png',
                          width: 60,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 245,
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
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SaglikIlerlemen()));
                },
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
                                  } else {
                                    return new Text("${snapshot.error}");
                                  }
                                  return CircularStepProgressIndicator(
                                    totalSteps: 100,
                                    currentStep: sonuclama(((DateTime.now()
                                                    .difference(DateTime.parse(
                                                        snapshot.data[0]
                                                            .birakmaDate))
                                                    .inDays) *
                                                100) ~/
                                            72)
                                        .toInt(),
                                    stepSize: 10,
                                    selectedColor: Colors.blue,
                                    unselectedColor: Colors.grey[200],
                                    padding: 0,
                                    width: 80,
                                    height: 80,
                                    selectedStepSize: 15,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 15, 0, 0),
                                      child: Text(
                                        sonuclamaYazisi((((DateTime.now()
                                                        .difference(DateTime
                                                            .parse(snapshot
                                                                .data[0]
                                                                .birakmaDate))
                                                        .inDays) *
                                                    100) ~/
                                                72)
                                            .toInt()),
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
                                  } else {
                                    return new Text("${snapshot.error}");
                                  }
                                  return CircularStepProgressIndicator(
                                    totalSteps: 100,
                                    currentStep: sonuclama(((DateTime.now()
                                                    .difference(DateTime.parse(
                                                        snapshot.data[0]
                                                            .birakmaDate))
                                                    .inDays) *
                                                100) ~/
                                            24)
                                        .toInt(),
                                    stepSize: 10,
                                    selectedColor: Colors.blue,
                                    unselectedColor: Colors.grey[200],
                                    padding: 0,
                                    width: 80,
                                    height: 80,
                                    selectedStepSize: 15,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          6, 15, 0, 0),
                                      child: Text(
                                        sonuclamaYazisi((((DateTime.now()
                                                        .difference(DateTime
                                                            .parse(snapshot
                                                                .data[0]
                                                                .birakmaDate))
                                                        .inDays) *
                                                    100) ~/
                                                24)
                                            .toInt()),
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
                                  } else {
                                    return new Text("${snapshot.error}");
                                  }
                                  return CircularStepProgressIndicator(
                                    totalSteps: 100,
                                    currentStep: sonuclama(((DateTime.now()
                                                    .difference(DateTime.parse(
                                                        snapshot.data[0]
                                                            .birakmaDate))
                                                    .inDays) *
                                                100) ~/
                                            48)
                                        .toInt(),
                                    stepSize: 10,
                                    selectedColor: Colors.blue,
                                    unselectedColor: Colors.grey[200],
                                    padding: 0,
                                    width: 80,
                                    height: 80,
                                    selectedStepSize: 15,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          6, 15, 0, 0),
                                      child: Text(
                                        sonuclamaYazisi((((DateTime.now()
                                                        .difference(DateTime
                                                            .parse(snapshot
                                                                .data[0]
                                                                .birakmaDate))
                                                        .inDays) *
                                                    100) ~/
                                                48)
                                            .toInt()),
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
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
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
                              _openPopup(context);
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
                      } else {
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
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black),
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
                                                        snapshot.data[0]
                                                            .birakmaDate))
                                                    .inDays *
                                                snapshot.data[0].gunlukIcme)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.blue),
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
                                            fontSize: 20, color: Colors.blue),
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
                                                    snapshot
                                                        .data[0].birakmaDate))
                                                .inHours)
                                            .toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.blue),
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
            RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Badges()));
                },
                child: FutureBuilder<List<BasariModel>>(
                    future: fetchBadgesFromDatabase(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Latest Achievements",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: snapshot.data[0].aciklama == null
                                            ? Text("Loading")
                                            : Text(
                                                "${snapshot.data[0].aciklama}"),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: snapshot.data[0].aciklama ==
                                                  null
                                              ? Text("Loading")
                                              : Text(
                                                  "${snapshot.data[0].aciklama}"),
                                        )),
                                  ),
                                  Card(
                                    child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: snapshot.data[2].aciklama ==
                                                  null
                                              ? Text("Loading")
                                              : Text(snapshot.data[2].aciklama),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      } else
                        Text(snapshot.error);
                    })),
          ]),
        ),
        floatingActionButton: ScaleTransition(
          scale: _hideFabAnimation,
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
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => AddDaily()),
                      );
                    }),
                IconButton(
                    icon: Icon(Icons.trending_down, color: Colors.white),
                    onPressed: () {})
              ]),
        ),
      ),
    );
  }
}
