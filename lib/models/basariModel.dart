class BasariModel {
  int id;
  String aciklama;
  String kategori;
  String tarih;
  String kazanildi;

  BasariModel(
      this.id, this.aciklama, this.kategori, this.tarih, this.kazanildi);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["aciklama"] = aciklama;
    map["kategori"] = kategori;
    map["tarih"] = tarih;
    map["kazanildi"] = kazanildi;

    return map;
  }

  BasariModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    aciklama = map["aciklama"];
    kategori = map["kategori"];
    tarih = map["tarih"];
    kazanildi = map["kazanildi"];
  }
}
