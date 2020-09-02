class SaveForModel {
  int id;
  String adi;
  String aciklama;
  int fiyat;

  SaveForModel(this.id, this.adi, this.aciklama, this.fiyat);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["adi"] = adi;
    map["aciklama"] = aciklama;
    map["fiyat"] = fiyat;

    return map;
  }

  SaveForModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    adi = map["adi"];
    aciklama = map["aciklama"];
    fiyat = map["fiyat"];
  }
}
