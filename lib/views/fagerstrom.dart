import 'package:flutter/material.dart';
import "package:custom_radio_grouped_button/custom_radio_grouped_button.dart";
import 'package:iknow/views/fagerSonuc.dart';

class FagerStrom extends StatefulWidget {
  @override
  _FagerStromState createState() => _FagerStromState();
}

class _FagerStromState extends State<FagerStrom> {
  final _formKey = GlobalKey<FormState>();
  int puan = 0;
  int _value;
  int _value2;
  int _value3;
  int radioValue;
  int radioValue2;
  int radioValue3;
  bool goster = false;
  int eksik = 0;

  List<int> cevaplar = List<int>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Fagerstrom Analiz",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  children: [
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                              "Uyandıktan ne kadar sonra ilk sigaranızı içiyorsunuz?"),
                          DropdownButton(
                              value: _value,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Seçiniz            "),
                                  value: null,
                                ),
                                DropdownMenuItem(
                                  child: Text("Bir saat sonra            "),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: Text("31-60 dakika içinde      "),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("5-30 dakika içinde"),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("ilk 5 dakikada"),
                                  value: 3,
                                )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                  cevaplar.add(value);
                                  print("value1 $_value");
                                });
                              }),
                        ],
                      ),
                    )),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                                "Sigara içmenin yasak olduğu yerlerde, sigara içmemek zor geliyor mu? (Örneğin okul, hastane, sinema, otobüs, toplantı vb) "),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: CustomRadioButton(
                                width: MediaQuery.of(context).size.width / 3,
                                buttonLables: [
                                  "Evet",
                                  "Hayır",
                                ],
                                buttonValues: [
                                  0,
                                  1,
                                ],
                                radioButtonValue: (value) {
                                  radioValue = value;
                                  cevaplar.add(value);
                                  print("radioValue $radioValue");
                                },
                                selectedColor: Colors.green,
                                unSelectedColor: Colors.grey,
                                enableShape: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                                "Hangi sigarayı bırakmak sizin için daha zor, yani hangisi sizin için  daha değerli?"),
                            SizedBox(
                              height: 20,
                            ),
                            DropdownButton(
                                value: _value2,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Seçiniz      "),
                                    value: null,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("İlk sigaram      "),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Digerleri  "),
                                    value: 0,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value2 = value;
                                    cevaplar.add(value);
                                    print("value2 $_value2");
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        children: [
                          Text("Her gün ortalama kaç adet sigara içiyorsunuz?"),
                          DropdownButton(
                              value: _value3,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Seçiniz    "),
                                  value: null,
                                ),
                                DropdownMenuItem(
                                  child: Text("10 veya daha az    "),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: Text("11 ile 20 arası	"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("21 ile 30 arası     "),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("31 ve üstü  "),
                                  value: 3,
                                )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _value3 = value;
                                  cevaplar.add(value);
                                  print("value3 $_value3");
                                });
                              }),
                        ],
                      ),
                    )),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                                "Uyandığınız ilk saatler içinde, gün içinde içtiğinizden daha çok sigara içiyor musunuz?"),
                            SizedBox(
                              height: 20,
                            ),
                            CustomRadioButton(
                              width: MediaQuery.of(context).size.width / 3,
                              buttonLables: [
                                "Evet",
                                "Hayır",
                              ],
                              buttonValues: [
                                0,
                                1,
                              ],
                              radioButtonValue: (value) {
                                radioValue2 = value;
                                cevaplar.add(value);
                                print("radioValue2 $radioValue2");
                              },
                              selectedColor: Colors.green,
                              unSelectedColor: Colors.grey,
                              enableShape: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                                "Hasta olduğunuz ve yatakta yatmak zorunda olduğunuz günlerde dahi sigara içer misiniz?"),
                            SizedBox(
                              height: 20,
                            ),
                            CustomRadioButton(
                              width: MediaQuery.of(context).size.width / 3,
                              buttonLables: [
                                "Evet",
                                "Hayır",
                              ],
                              buttonValues: [
                                1,
                                0,
                              ],
                              radioButtonValue: (value) {
                                radioValue3 = value;
                                cevaplar.add(value);
                                print("radioValue3 $radioValue3");
                              },
                              selectedColor: Colors.green,
                              unSelectedColor: Colors.grey,
                              enableShape: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                        visible: goster,
                        child: Container(
                            child: Column(
                          children: [
                            Text(
                              "UYARI!:  Lütfen tüm alanları doldurunuz.",
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ))),
                    Container(
                      width: 250,
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.green),
                          ),
                          onPressed: () {
                            puan = 0;
                            if (cevaplar.length < 6) {
                              print("cevap ${cevaplar.length}");
                              setState(() {
                                goster = true;
                              });
                            } else {
                              for (var i = 0; i < cevaplar.length; i++) {
                                print("cevap degeri ${cevaplar[i]}");
                                puan += cevaplar[i];
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FagerSonuc(
                                          puan: puan,
                                        )),
                              );
                            }
                          },
                          child: Text("Bitir")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
