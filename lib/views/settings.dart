import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            item(Icons.notifications, "Bildirim Ayarları",
                "Bildirim izinleri ve ayarları.", context),
            item(Icons.date_range, "Bırakma Tarihi",
                "Sigarayı bırakmak istediğiniz tarihi seçin.", context),
            item(Icons.account_box, "Hesap Ayarları",
                "Hesaplarınızı bağlayın, yönetin", context)
          ],
        ),
      ),
    );
  }
}

Widget item(
    IconData iconIsmi, String baslik, String aciklama, BuildContext context) {
  return Card(
    elevation: 2,
    child: FlatButton(
      onPressed: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 8,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(iconIsmi),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baslik,
                  style: TextStyle(fontSize: 16),
                ),
                Text(aciklama)
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
