class MissionModel {
  int id;
  String baslik;
  String aciklama;
  String tamamlandi;

  MissionModel(this.id, this.baslik, this.aciklama, this.tamamlandi);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["baslik"] = baslik;
    map["aciklama"] = aciklama;
    map["tamamlandi"] = tamamlandi;

    return map;
  }

  MissionModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    baslik = map["baslik"];
    aciklama = map["aciklama"];
    tamamlandi = map["tamamlandi"];
  }
}
