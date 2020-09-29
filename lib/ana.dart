import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iknow/cravings.dart';
import 'package:iknow/views/missions.dart';
import 'package:iknow/views/takvimAna.dart';
import 'main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: must_be_immutable
class AnaSayfa extends StatefulWidget {
  int indis;
  AnaSayfa({this.indis});
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  int _currentIndex = 0;
  final List<Widget> _children = [HomePage(), MyApp(), Cravings(), Missions()];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    initializing();
    if (widget.indis != null) _currentIndex = widget.indis;
    _showNotifications();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications() async {
    await notification();
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 'Sigara gündelik', 'Channel body',
            //priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    // await flutterLocalNotificationsPlugin.show(0, "Hello there",
    //     "Bugün sigara günlüğü girmediniz", notificationDetails);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Sigara Bırakma Uygulaması',
        'Bugünün günlüğünü gir',
        Time(22, 30, 0),
        notificationDetails);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) print(payLoad);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                print("");
              },
              child: Text("Okay"))
        ]);
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
            title: Text('Görevler'),
          ),
        ],

        selectedItemColor: Colors.lightGreen,
      ),
    );
  }
}
