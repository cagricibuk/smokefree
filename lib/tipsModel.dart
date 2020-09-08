class TipsModel {
  int id;
  String aciklama;
  String isFavorite;
  String kategori;

  TipsModel(this.id, this.aciklama, this.isFavorite, this.kategori);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["aciklama"] = aciklama;
    map["isFavorite"] = isFavorite;
    map["kategori"] = kategori;

    return map;
  }

  TipsModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    aciklama = map["aciklama"];
    isFavorite = map["isFavorite"];
    kategori = map["kategori"];
  }
}
